import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../shared/models/savings_goal.dart';
import '../providers/savings_providers.dart';

class SavingsGoalsScreen extends ConsumerWidget {
  const SavingsGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(savingsGoalsProvider);

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('Savings Goals'),
      ),
      body: goalsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.accentPurple)),
        error: (e, _) =>
            Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
        data: (goals) => goals.isEmpty
            ? _emptyState(context, ref)
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: goals.length,
                itemBuilder: (ctx, i) => _GoalCard(
                  goal: goals[i],
                  onAddFunds: () => _showAddFundsSheet(context, ref, goals[i]),
                  onDelete: () =>
                      ref.read(savingsNotifierProvider.notifier).delete(goals[i].id),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGoalSheet(context, ref),
        backgroundColor: AppColors.accentPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Goal', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _emptyState(BuildContext context, WidgetRef ref) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.savings_outlined, color: Colors.white24, size: 64),
            const SizedBox(height: 16),
            const Text('No savings goals yet',
                style: TextStyle(color: Colors.white54, fontSize: 16)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _showAddGoalSheet(context, ref),
              child: const Text('Create a goal',
                  style: TextStyle(color: AppColors.accentPurple)),
            ),
          ],
        ),
      );

  void _showAddGoalSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _AddGoalSheet(ref: ref),
    );
  }

  void _showAddFundsSheet(BuildContext context, WidgetRef ref, SavingsGoal goal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _AddFundsSheet(goal: goal, ref: ref),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final VoidCallback onAddFunds;
  final VoidCallback onDelete;

  const _GoalCard({
    required this.goal,
    required this.onAddFunds,
    required this.onDelete,
  });

  Color _hexColor(String hex) {
    try {
      return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return AppColors.accentPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _hexColor(goal.color);
    final pct = goal.progress.clamp(0.0, 1.0);
    final remaining = goal.target - goal.current;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.savings_outlined, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    if (goal.deadline != null)
                      Text(
                        'By ${goal.deadline!.day}/${goal.deadline!.month}/${goal.deadline!.year}',
                        style:
                            const TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.expense, size: 18),
                onPressed: onDelete,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(pct * 100).toStringAsFixed(0)}% • ${CurrencyFormatter.formatCompact(goal.current)} saved',
                style: TextStyle(color: color, fontSize: 12),
              ),
              Text(
                '${CurrencyFormatter.formatCompact(remaining.clamp(0, double.infinity))} to go',
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onAddFunds,
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Add Funds'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddGoalSheet extends StatefulWidget {
  final WidgetRef ref;
  const _AddGoalSheet({required this.ref});

  @override
  State<_AddGoalSheet> createState() => _AddGoalSheetState();
}

class _AddGoalSheetState extends State<_AddGoalSheet> {
  final _nameCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  DateTime? _deadline;
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final target = double.tryParse(_targetCtrl.text);
    if (_nameCtrl.text.isEmpty || target == null || target <= 0) return;
    setState(() => _saving = true);
    await widget.ref.read(savingsNotifierProvider.notifier).add(
          name: _nameCtrl.text.trim(),
          target: target,
          deadline: _deadline,
        );
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickDeadline() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.dark(primary: AppColors.accentPurple),
        ),
        child: child!,
      ),
    );
    if (d != null) setState(() => _deadline = d);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('New Savings Goal',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _Field(controller: _nameCtrl, label: 'Goal name'),
          const SizedBox(height: 12),
          _Field(
              controller: _targetCtrl,
              label: 'Target amount (₹)',
              numeric: true),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _pickDeadline,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: Colors.white38, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    _deadline == null
                        ? 'Set deadline (optional)'
                        : 'By ${_deadline!.day}/${_deadline!.month}/${_deadline!.year}',
                    style: TextStyle(
                        color: _deadline == null
                            ? Colors.white38
                            : Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(_saving ? 'Saving…' : 'Create Goal'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddFundsSheet extends StatefulWidget {
  final SavingsGoal goal;
  final WidgetRef ref;
  const _AddFundsSheet({required this.goal, required this.ref});

  @override
  State<_AddFundsSheet> createState() => _AddFundsSheetState();
}

class _AddFundsSheetState extends State<_AddFundsSheet> {
  final _amountCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;
    setState(() => _saving = true);
    await widget.ref
        .read(savingsNotifierProvider.notifier)
        .addFunds(widget.goal.id, amount);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add funds to "${widget.goal.name}"',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _Field(controller: _amountCtrl, label: 'Amount (₹)', numeric: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(_saving ? 'Saving…' : 'Add Funds'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool numeric;

  const _Field({
    required this.controller,
    required this.label,
    this.numeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType:
          numeric ? const TextInputType.numberWithOptions(decimal: true) : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.accentPurple, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.cardDark,
      ),
    );
  }
}
