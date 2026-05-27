import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/transaction.dart';
import '../providers/transaction_providers.dart';
import '../widgets/transaction_tile.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() =>
      _TransactionListScreenState();
}

class _TransactionListScreenState
    extends ConsumerState<TransactionListScreen> {
  String _search = '';
  TransactionType? _filterType;

  @override
  Widget build(BuildContext context) {
    final txnAsync = ref.watch(allTransactionsProvider);

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('All Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppConstants.routeAddTransaction),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (v) => setState(() => _search = v.toLowerCase()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search transactions…',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white38),
                filled: true,
                fillColor: AppColors.cardDark,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: AnimatedBackground(
        child: Column(
          children: [
          // Type filter chips
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _filterType == null,
                  onTap: () => setState(() => _filterType = null),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Expenses',
                  selected: _filterType == TransactionType.debit,
                  color: AppColors.expense,
                  onTap: () => setState(
                      () => _filterType = TransactionType.debit),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Income',
                  selected: _filterType == TransactionType.credit,
                  color: AppColors.income,
                  onTap: () => setState(
                      () => _filterType = TransactionType.credit),
                ),
              ],
            ),
          ),
          // Transaction list
          Expanded(
            child: txnAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                  child: Text('Error: $e',
                      style: const TextStyle(color: Colors.red))),
              data: (txns) {
                final filtered = txns.where((t) {
                  if (_filterType != null && t.type != _filterType) return false;
                  if (_search.isNotEmpty) {
                    final merchant =
                        (t.merchant ?? '').toLowerCase();
                    final note = (t.note ?? '').toLowerCase();
                    if (!merchant.contains(_search) &&
                        !note.contains(_search)) {
                      return false;
                    }
                  }
                  return true;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            color: Colors.white24, size: 64),
                        SizedBox(height: 16),
                        Text('No transactions found',
                            style: TextStyle(color: Colors.white38)),
                      ],
                    ),
                  );
                }

                // Group by date
                final grouped = <String, List<Transaction>>{};
                for (final t in filtered) {
                  final key = AppDateUtils.relativeLabel(t.timestamp);
                  grouped.putIfAbsent(key, () => []).add(t);
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: grouped.length,
                  itemBuilder: (ctx, i) {
                    final date = grouped.keys.elementAt(i);
                    final items = grouped[date]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            date,
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                        ),
                        ...items.map((t) => TransactionTile(
                              transaction: t,
                              onTap: () => context.push(
                                  AppConstants.routeEditTransaction,
                                  extra: t),
                              onDelete: () => ref
                                  .read(transactionFormProvider.notifier)
                                  .remove(t.id),
                            )),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppConstants.routeAddTransaction),
        backgroundColor: AppColors.accentPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label:
            const Text('Add', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.accentPurple;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? c : Colors.white.withValues(alpha: 0.1)),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? c : Colors.white54,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13)),
      ),
    );
  }
}
