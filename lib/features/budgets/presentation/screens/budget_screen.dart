import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../shared/models/budget.dart';
import '../../../../shared/models/category.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../providers/budget_providers.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enriched = ref.watch(enrichedBudgetsProvider);
    final cats = ref.watch(categoriesProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('Budgets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddBudgetSheet(context, ref, cats),
          ),
        ],
      ),
      body: enriched.isEmpty
          ? _emptyState(context, ref, cats)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: enriched.length,
              itemBuilder: (ctx, i) {
                final item = enriched[i];
                return _BudgetCard(
                  budget: item.budget,
                  category: item.category,
                  onEdit: () =>
                      _showAddBudgetSheet(context, ref, cats, existing: item.budget),
                  onDelete: () =>
                      ref.read(budgetNotifierProvider.notifier).delete(item.budget.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBudgetSheet(context, ref, cats),
        backgroundColor: AppColors.accentPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Budget', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _emptyState(BuildContext context, WidgetRef ref, List<Category> cats) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.account_balance_wallet_outlined,
              color: Colors.white24, size: 64),
          const SizedBox(height: 16),
          const Text('No budgets set',
              style: TextStyle(color: Colors.white54, fontSize: 16)),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _showAddBudgetSheet(context, ref, cats),
            child: const Text('Create your first budget',
                style: TextStyle(color: AppColors.accentPurple)),
          ),
        ],
      ),
    );
  }

  void _showAddBudgetSheet(
    BuildContext context,
    WidgetRef ref,
    List<Category> cats, {
    Budget? existing,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddBudgetSheet(cats: cats, existing: existing, ref: ref),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final Budget budget;
  final Category? category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BudgetCard({
    required this.budget,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final pct = budget.percentUsed.clamp(0.0, 1.0);
    final isOver = pct >= 1.0;
    final isWarning = pct >= budget.alertAt && !isOver;
    final barColor = isOver
        ? AppColors.expense
        : isWarning
            ? AppColors.warning
            : AppColors.accentPurple;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  category?.name ?? budget.categoryId,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    color: Colors.white38, size: 18),
                onPressed: onEdit,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.expense, size: 18),
                onPressed: onDelete,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(barColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${CurrencyFormatter.formatCompact(budget.spent)} spent',
                style: TextStyle(color: barColor, fontSize: 13),
              ),
              Text(
                'of ${CurrencyFormatter.formatCompact(budget.amount)}',
                style: const TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
          if (isOver)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Over budget by ${CurrencyFormatter.formatCompact(budget.spent - budget.amount)}',
                style: const TextStyle(color: AppColors.expense, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddBudgetSheet extends StatefulWidget {
  final List<Category> cats;
  final Budget? existing;
  final WidgetRef ref;

  const _AddBudgetSheet({
    required this.cats,
    required this.existing,
    required this.ref,
  });

  @override
  State<_AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends State<_AddBudgetSheet> {
  final _amountCtrl = TextEditingController();
  late String _categoryId;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _categoryId =
        widget.existing?.categoryId ?? widget.cats.firstOrNull?.id ?? '';
    if (widget.existing != null) {
      _amountCtrl.text = widget.existing!.amount.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;
    setState(() => _saving = true);
    await widget.ref.read(budgetNotifierProvider.notifier).upsert(
          existingId: widget.existing?.id,
          categoryId: _categoryId,
          amount: amount,
        );
    if (mounted) Navigator.of(context).pop();
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
          Text(
            widget.existing == null ? 'New Budget' : 'Edit Budget',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: _categoryId.isEmpty ? null : _categoryId,
            dropdownColor: AppColors.cardDark,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDeco('Category'),
            items: widget.cats
                .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                .toList(),
            onChanged: (v) => setState(() => _categoryId = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: Colors.white),
            decoration: _inputDeco('Monthly limit (₹)'),
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
              child: Text(_saving ? 'Saving…' : 'Save Budget'),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.accentPurple, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.cardDark,
      );
}
