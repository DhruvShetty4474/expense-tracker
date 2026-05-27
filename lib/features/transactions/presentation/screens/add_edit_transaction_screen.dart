import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/transaction.dart';
import '../providers/transaction_providers.dart';

class AddEditTransactionScreen extends ConsumerStatefulWidget {
  final Transaction? existing;
  const AddEditTransactionScreen({super.key, this.existing});

  @override
  ConsumerState<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState
    extends ConsumerState<AddEditTransactionScreen> {
  final _amountCtrl = TextEditingController();
  final _merchantCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  TransactionType _type = TransactionType.debit;
  String _categoryId = 'cat_other';
  DateTime _date = DateTime.now();
  bool _saving = false;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final t = widget.existing!;
      _amountCtrl.text = t.amount.toStringAsFixed(2);
      _merchantCtrl.text = t.merchant ?? '';
      _noteCtrl.text = t.note ?? '';
      _type = t.type;
      _categoryId = t.categoryId;
      _date = t.timestamp;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _merchantCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      _showError('Enter a valid amount');
      return;
    }
    setState(() => _saving = true);
    try {
      final notifier = ref.read(transactionFormProvider.notifier);
      if (_isEditing) {
        await notifier.edit(widget.existing!.copyWith(
          amount: amount,
          type: _type,
          categoryId: _categoryId,
          merchant: _merchantCtrl.text.trim().isEmpty
              ? null
              : _merchantCtrl.text.trim(),
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
          timestamp: _date,
        ));
      } else {
        await notifier.add(
          amount: amount,
          type: _type,
          categoryId: _categoryId,
          timestamp: _date,
          merchant: _merchantCtrl.text.trim().isEmpty
              ? null
              : _merchantCtrl.text.trim(),
          note:
              _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        );
      }
      if (mounted) context.pop();
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.accentPurple),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final cats = ref.watch(categoriesProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: Text(_isEditing ? 'Edit Transaction' : 'Add Transaction'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Save',
                  style: TextStyle(
                      color: AppColors.accentPurple,
                      fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      body: AnimatedBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Type toggle
            GlassCard(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  _TypeTab(
                    label: 'Expense',
                    icon: Icons.arrow_upward_rounded,
                    selected: _type == TransactionType.debit,
                    color: AppColors.expense,
                    onTap: () => setState(() => _type = TransactionType.debit),
                  ),
                  _TypeTab(
                    label: 'Income',
                    icon: Icons.arrow_downward_rounded,
                    selected: _type == TransactionType.credit,
                    color: AppColors.income,
                    onTap: () =>
                        setState(() => _type = TransactionType.credit),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Amount
            _DarkField(
              controller: _amountCtrl,
              label: 'Amount',
              prefix: '₹',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              large: true,
            ),
            const SizedBox(height: 16),

            // Merchant
            _DarkField(
              controller: _merchantCtrl,
              label: 'Merchant / Payee (optional)',
              icon: Icons.store_outlined,
            ),
            const SizedBox(height: 16),

            // Category
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonFormField<String>(
                initialValue: cats.any((c) => c.id == _categoryId)
                    ? _categoryId
                    : (cats.isNotEmpty ? cats.first.id : null),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  labelStyle:
                      TextStyle(color: Colors.white54, fontSize: 13),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.label_outline,
                      color: Colors.white38, size: 20),
                ),
                dropdownColor: AppColors.cardDark,
                style: const TextStyle(color: Colors.white),
                items: cats
                    .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.name),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _categoryId = v!),
              ),
            ),
            const SizedBox(height: 16),

            // Date picker
            GlassCard(
              onTap: _pickDate,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: Colors.white38, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${_date.day}/${_date.month}/${_date.year}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: Colors.white38, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Note
            _DarkField(
              controller: _noteCtrl,
              label: 'Note (optional)',
              icon: Icons.notes_outlined,
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  _isEditing ? 'Update Transaction' : 'Add Transaction',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _TypeTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _TypeTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: selected
                ? Border.all(color: color.withValues(alpha: 0.4))
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? color : Colors.white38, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? color : Colors.white38,
                  fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DarkField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? prefix;
  final IconData? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool large;

  const _DarkField({
    required this.controller,
    required this.label,
    this.prefix,
    this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: TextStyle(
        color: Colors.white,
        fontSize: large ? 28 : 16,
        fontWeight: large ? FontWeight.bold : FontWeight.normal,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
        prefixText: prefix,
        prefixStyle: const TextStyle(
            color: Colors.white54, fontSize: 28, fontWeight: FontWeight.bold),
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.white38, size: 20)
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: AppColors.accentPurple, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.cardDark,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: large ? 20 : 14),
      ),
    );
  }
}
