import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/animated_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../../features/transactions/presentation/widgets/transaction_tile.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final monthlySpent = ref.watch(monthlySpendingProvider);
    final monthlyIncome = ref.watch(monthlyIncomeProvider);
    final todaySpent = ref.watch(todaySpendingProvider);
    final weekSpent = ref.watch(weekSpendingProvider);
    final recentTxns = ref.watch(allTransactionsProvider);
    final user = ref.watch(currentUserProvider);
    final displayName = user?.displayName?.split(' ').first ?? 'there';

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _greeting(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              displayName == 'there' ? 'FinAI Dashboard' : 'Hi, $displayName',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
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
            ref.invalidate(allTransactionsProvider);
          },
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.paddingOf(context).top + kToolbarHeight + 8),
                  ),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 18,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.accentPurple,
                                      AppColors.accentCyan,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Recent Transactions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
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
                        return SliverToBoxAdapter(
                          child: GlassCard(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(40),
                            borderRadius: 20,
                            child: Column(
                              children: [
                                Icon(Icons.receipt_long_outlined,
                                    color: Colors.white.withValues(alpha: 0.2), size: 56),
                                const SizedBox(height: 16),
                                Text(
                                  'No transactions yet.\nTap + to add one.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.35)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final recent = txns.take(20).toList();
                      return SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        sliver: SliverList.builder(
                          itemCount: recent.length,
                          itemBuilder: (ctx, i) => TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(milliseconds: 350 + (i * 40).clamp(0, 400)),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) => Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 12 * (1 - value)),
                                child: child,
                              ),
                            ),
                            child: TransactionTile(
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppConstants.routeAddTransaction),
        backgroundColor: AppColors.accentPurple,
        elevation: 8,
        highlightElevation: 12,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _TotalExpenseCard extends StatefulWidget {
  final AsyncValue<double> spentAsync;
  final AsyncValue<double> incomeAsync;

  const _TotalExpenseCard({
    required this.spentAsync,
    required this.incomeAsync,
  });

  @override
  State<_TotalExpenseCard> createState() => _TotalExpenseCardState();
}

class _TotalExpenseCardState extends State<_TotalExpenseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _progressAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic);
    _animCtrl.forward();
  }

  @override
  void didUpdateWidget(_TotalExpenseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animCtrl
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spent = widget.spentAsync.valueOrNull ?? 0;
    final income = widget.incomeAsync.valueOrNull ?? 0;
    final net = income - spent;
    final progress = income > 0 ? (spent / income).clamp(0.0, 1.0) : 0.0;

    return GlassCard(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(22),
      borderRadius: 24,
      blurSigma: 16,
      backgroundColor: AppColors.accentPurple.withValues(alpha: 0.12),
      borderColor: AppColors.accentPurple.withValues(alpha: 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'This Month',
                  style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              Icon(Icons.trending_up_rounded,
                  color: AppColors.accentCyan.withValues(alpha: 0.8), size: 20),
            ],
          ),
          const SizedBox(height: 14),
          widget.spentAsync.when(
            loading: () => const SizedBox(
              height: 44,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accentPurple),
              ),
            ),
            error: (_, __) => const Text('—',
                style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold)),
            data: (v) => _AnimatedAmount(
              amount: v,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            net >= 0
                ? '₹${CurrencyFormatter.formatCompact(net)} remaining'
                : '₹${CurrencyFormatter.formatCompact(net.abs())} over budget',
            style: TextStyle(
              color: net >= 0 ? AppColors.income : AppColors.expense,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (_, __) {
              final animatedProgress = progress * _progressAnim.value;
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: animatedProgress,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation(
                        progress > 0.9 ? AppColors.expense : AppColors.accentPurple,
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(animatedProgress * 100).toStringAsFixed(0)}% of income used',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.35),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatChip(
                  label: 'Spent',
                  value: CurrencyFormatter.formatCompact(spent),
                  color: AppColors.expense,
                  icon: Icons.arrow_upward_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatChip(
                  label: 'Income',
                  value: CurrencyFormatter.formatCompact(income),
                  color: AppColors.income,
                  icon: Icons.arrow_downward_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedAmount extends StatelessWidget {
  final double amount;
  final TextStyle style;

  const _AnimatedAmount({required this.amount, required this.style});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: amount),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (_, value, __) => Text(
        CurrencyFormatter.format(value),
        style: style,
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      borderRadius: 14,
      blurSigma: 8,
      backgroundColor: color.withValues(alpha: 0.08),
      borderColor: color.withValues(alpha: 0.2),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: color.withValues(alpha: 0.8), fontSize: 11)),
                Text(
                  '₹$value',
                  style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
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
          _SummaryCell(label: 'Today', valueAsync: todayAsync, icon: Icons.wb_sunny_outlined),
          const SizedBox(width: 8),
          _SummaryCell(label: 'Week', valueAsync: weekAsync, icon: Icons.date_range_outlined),
          const SizedBox(width: 8),
          _SummaryCell(label: 'Month', valueAsync: monthAsync, icon: Icons.calendar_month_outlined),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  final String label;
  final AsyncValue<double> valueAsync;
  final IconData icon;

  const _SummaryCell({
    required this.label,
    required this.valueAsync,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        borderRadius: 16,
        blurSigma: 10,
        child: Column(
          children: [
            Icon(icon, color: AppColors.accentPurple.withValues(alpha: 0.7), size: 18),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11)),
            const SizedBox(height: 4),
            valueAsync.when(
              loading: () => const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.accentPurple),
              ),
              error: (_, __) => const Text('—', style: TextStyle(color: Colors.white)),
              data: (v) => TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: v),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (_, value, __) => Text(
                  '₹${CurrencyFormatter.formatCompact(value)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
