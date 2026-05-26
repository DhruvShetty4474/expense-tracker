import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/animated_background.dart';
import '../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../../features/transactions/presentation/widgets/transaction_tile.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlySpent = ref.watch(monthlySpendingProvider);
    final monthlyIncome = ref.watch(monthlyIncomeProvider);
    final todaySpent = ref.watch(todaySpendingProvider);
    final weekSpent = ref.watch(weekSpendingProvider);
    final recentTxns = ref.watch(allTransactionsProvider);

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppConstants.routeTransactions),
            icon: const Icon(Icons.receipt_long_outlined),
          ),
        ],
      ),
      body: AnimatedBackground(
        child: RefreshIndicator(
          color: AppColors.accentPurple,
          backgroundColor: AppColors.cardDark,
          onRefresh: () async {
            ref.invalidate(monthlySpendingProvider);
            ref.invalidate(monthlyIncomeProvider);
            ref.invalidate(todaySpendingProvider);
            ref.invalidate(weekSpendingProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _TotalExpenseCard(
                      spentAsync: monthlySpent,
                      incomeAsync: monthlyIncome,
                    ),
                    _SummaryRow(
                      todayAsync: todaySpent,
                      weekAsync: weekSpent,
                      monthAsync: monthlySpent,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recent Transactions',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              recentTxns.when(
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(color: AppColors.accentPurple),
                    ),
                  ),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
                  ),
                ),
                data: (txns) {
                  if (txns.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(48),
                          child: Column(
                            children: [
                              Icon(Icons.receipt_long_outlined,
                                  color: Colors.white24, size: 64),
                              SizedBox(height: 16),
                              Text(
                                'No transactions yet.\nTap + to add one.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white38),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  final recent = txns.take(20).toList();
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    sliver: SliverList.builder(
                      itemCount: recent.length,
                      itemBuilder: (ctx, i) => TransactionTile(
                        transaction: recent[i],
                        onTap: () => context.push(
                          AppConstants.routeEditTransaction,
                          extra: recent[i],
                        ),
                        onDelete: () => ref
                            .read(transactionFormProvider.notifier)
                            .remove(recent[i].id),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppConstants.routeAddTransaction),
        backgroundColor: AppColors.accentPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _TotalExpenseCard extends StatelessWidget {
  final AsyncValue<double> spentAsync;
  final AsyncValue<double> incomeAsync;

  const _TotalExpenseCard({
    required this.spentAsync,
    required this.incomeAsync,
  });

  @override
  Widget build(BuildContext context) {
    final spent = spentAsync.valueOrNull ?? 0;
    final income = incomeAsync.valueOrNull ?? 0;
    final net = income - spent;
    final progress = income > 0 ? (spent / income).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentPurple.withValues(alpha: 0.3),
            AppColors.cardDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Month',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 8),
          spentAsync.when(
            loading: () => const SizedBox(
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.accentPurple),
              ),
            ),
            error: (_, __) => const Text('—',
                style: TextStyle(color: Colors.white, fontSize: 36)),
            data: (v) => Text(
              CurrencyFormatter.format(v),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            net >= 0
                ? '₹${CurrencyFormatter.formatCompact(net)} remaining'
                : '₹${CurrencyFormatter.formatCompact(net.abs())} over budget',
            style: TextStyle(
              color: net >= 0 ? AppColors.income : AppColors.expense,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(
                progress > 0.9 ? AppColors.expense : AppColors.accentPurple,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatChip(
                label: 'Spent',
                value: CurrencyFormatter.formatCompact(spent),
                color: AppColors.expense,
              ),
              _StatChip(
                label: 'Income',
                value: CurrencyFormatter.formatCompact(income),
                color: AppColors.income,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label  ₹$value',
          style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final AsyncValue<double> todayAsync;
  final AsyncValue<double> weekAsync;
  final AsyncValue<double> monthAsync;

  const _SummaryRow({
    required this.todayAsync,
    required this.weekAsync,
    required this.monthAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _SummaryCell(label: 'Today', valueAsync: todayAsync),
          _Divider(),
          _SummaryCell(label: 'Week', valueAsync: weekAsync),
          _Divider(),
          _SummaryCell(label: 'Month', valueAsync: monthAsync),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white12,
    );
  }
}

class _SummaryCell extends StatelessWidget {
  final String label;
  final AsyncValue<double> valueAsync;

  const _SummaryCell({required this.label, required this.valueAsync});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 4),
            valueAsync.when(
              loading: () => const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                    strokeWidth: 1.5, color: AppColors.accentPurple),
              ),
              error: (_, __) =>
                  const Text('—', style: TextStyle(color: Colors.white)),
              data: (v) => Text(
                '₹${CurrencyFormatter.formatCompact(v)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
