import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../services/ai/ai_service_resolver.dart';
import '../../../ai_assistant/presentation/providers/ai_chat_provider.dart';
import '../../../../services/sync/sync_providers.dart';
import '../providers/analytics_providers.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int? _touchedIndex;

  void _shiftMonth(int delta) {
    final cur = ref.read(analyticsMonthProvider);
    ref.read(analyticsMonthProvider.notifier).state =
        DateTime(cur.year, cur.month + delta);
  }

  @override
  Widget build(BuildContext context) {
    final month = ref.watch(analyticsMonthProvider);
    final monthLabel = DateFormat('MMMM yyyy').format(month);
    final spent = ref.watch(analyticsMonthSpendingProvider).valueOrNull ?? 0;
    final income = ref.watch(analyticsMonthIncomeProvider).valueOrNull ?? 0;
    final prevSpent =
        ref.watch(analyticsPrevMonthSpendingProvider).valueOrNull ?? 0;
    final categoryData = ref.watch(categorySpendingEnrichedProvider);
    final dailyData = ref.watch(dailySpendingProvider);
    final merchants = ref.watch(topMerchantsProvider);
    final budgets = ref.watch(budgetVsActualProvider);
    final storage = ref.watch(storageEstimateProvider);
    final aiInsight = ref.watch(aiInsightProvider);
    final syncStatus = ref.watch(syncStatusProvider);

    final net = income - spent;
    final savingsRate = income > 0 ? (net / income).clamp(0, 1) : 0.0;
    final momChange = prevSpent > 0
        ? ((spent - prevSpent) / prevSpent * 100)
        : null;

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _shiftMonth(-1),
          ),
          Text(monthLabel,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: month.year == DateTime.now().year &&
                    month.month == DateTime.now().month
                ? null
                : () => _shiftMonth(1),
          ),
        ],
      ),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            // ── Summary row ─────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Spent',
                    value: CurrencyFormatter.formatCompact(spent),
                    color: AppColors.expense,
                    icon: Icons.arrow_upward_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(
                    label: 'Income',
                    value: CurrencyFormatter.formatCompact(income),
                    color: AppColors.income,
                    icon: Icons.arrow_downward_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Net',
                    value: CurrencyFormatter.formatCompact(net),
                    color: net >= 0 ? AppColors.accentGreen : AppColors.error,
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(
                    label: 'Saved',
                    value: '${(savingsRate * 100).toStringAsFixed(0)}%',
                    color: AppColors.accentCyan,
                    icon: Icons.savings_outlined,
                  ),
                ),
              ],
            ),

            if (momChange != null) ...[
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(
                      momChange >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: momChange >= 0
                          ? AppColors.expense
                          : AppColors.accentGreen,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        momChange >= 0
                            ? 'Spending up ${momChange.abs().toStringAsFixed(1)}% vs last month'
                            : 'Spending down ${momChange.abs().toStringAsFixed(1)}% vs last month',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.formatCompact(prevSpent),
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],

            // ── AI insight ────────────────────────────────────────────────
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(16),
              borderColor: AppColors.accentPurple.withValues(alpha: 0.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: AppColors.accentPurple, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'FinAI Insight · ${activeAiProviderLabel()}',
                        style: const TextStyle(
                          color: AppColors.accentPurple,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  aiInsight.when(
                    loading: () => const Text('Analyzing your patterns…',
                        style: TextStyle(color: Colors.white38, fontSize: 13)),
                    error: (_, __) => const Text(
                      'AI insight unavailable — check your API key in .env',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                    data: (text) => Text(text,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.45)),
                  ),
                ],
              ),
            ),

            // ── Budget vs actual ──────────────────────────────────────────
            if (budgets.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionTitle('Budget vs Actual'),
              ...budgets.take(5).map((b) {
                final color = b.pct >= 1
                    ? AppColors.error
                    : b.pct >= 0.85
                        ? AppColors.accentAmber
                        : AppColors.accentGreen;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                b.category?.name ?? 'Category',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                            ),
                            Text(
                              '${CurrencyFormatter.formatCompact(b.spent)} / ${CurrencyFormatter.formatCompact(b.budget)}',
                              style: TextStyle(color: color, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: b.pct.clamp(0, 1),
                            minHeight: 6,
                            backgroundColor: Colors.white.withValues(alpha: 0.08),
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],

            // ── Trend chart ───────────────────────────────────────────────
            if (dailyData.any((d) => d.amount > 0)) ...[
              const SizedBox(height: 16),
              _SectionTitle('30-Day Spending Trend'),
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 170,
                  child: Builder(builder: (context) {
                    final maxDaily = dailyData
                        .map((d) => d.amount)
                        .fold<double>(0, (a, b) => a > b ? a : b);
                    final interval = maxDaily > 0 ? maxDaily / 4 : 100.0;
                    return LineChart(
                    LineChartData(
                      minY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: interval,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: Colors.white.withValues(alpha: 0.06),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 7,
                            getTitlesWidget: (val, _) {
                              final i = val.toInt();
                              if (i < 0 || i >= dailyData.length) {
                                return const SizedBox.shrink();
                              }
                              final d = dailyData[i].date;
                              return Text('${d.day}/${d.month}',
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 10));
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: dailyData
                              .asMap()
                              .entries
                              .map((e) =>
                                  FlSpot(e.key.toDouble(), e.value.amount))
                              .toList(),
                          isCurved: true,
                          color: AppColors.accentPurple,
                          barWidth: 2.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color:
                                AppColors.accentPurple.withValues(alpha: 0.12),
                          ),
                        ),
                      ],
                    ),
                  );
                  }),
                ),
              ),
            ],

            // ── Categories ────────────────────────────────────────────────
            if (categoryData.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionTitle('Spending by Category'),
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 48,
                          pieTouchData: PieTouchData(
                            touchCallback: (event, response) {
                              setState(() {
                                _touchedIndex = response?.touchedSection != null
                                    ? response!.touchedSection!
                                        .touchedSectionIndex
                                    : null;
                              });
                            },
                          ),
                          sections: categoryData.asMap().entries.map((e) {
                            final i = e.key;
                            final item = e.value;
                            final isTouched = i == _touchedIndex;
                            final color = _hexColor(item.category.color);
                            return PieChartSectionData(
                              value: item.amount,
                              color: color,
                              radius: isTouched ? 54 : 44,
                              title: isTouched
                                  ? '${(item.pct * 100).toStringAsFixed(0)}%'
                                  : '',
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...categoryData.map((item) {
                      final color = _hexColor(item.category.color);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: color, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(item.category.name,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 13)),
                            ),
                            Text(
                              '${(item.pct * 100).toStringAsFixed(0)}%  ${CurrencyFormatter.formatCompact(item.amount)}',
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],

            // ── Top merchants ───────────────────────────────────────────
            if (merchants.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionTitle('Top Merchants'),
              ...merchants.take(8).map((m) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.accentCyan
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.store_outlined,
                                color: AppColors.accentCyan, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                                Text('${m.count} payments',
                                    style: const TextStyle(
                                        color: Colors.white38, fontSize: 11)),
                              ],
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatCompact(m.amount),
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],

            // ── Storage info ──────────────────────────────────────────────
            const SizedBox(height: 16),
            _SectionTitle('Data Storage'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.storage_rounded,
                          color: AppColors.accentGreen, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        '${storage.transactionCount} transactions · ${storage.localMb.toStringAsFixed(2)} MB local',
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    storage.summary,
                    style: const TextStyle(
                        color: Colors.white38, fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: storage.firebaseUsagePercent / 100,
                      minHeight: 5,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      color: storage.withinFirebaseFreeTier
                          ? AppColors.accentGreen
                          : AppColors.accentAmber,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Firebase free tier: ${storage.firebaseUsagePercent.toStringAsFixed(2)}% used if fully synced',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Local SQLite keeps full history for speed. Cloud sync (optional) prunes H2 of previous year each January.',
                    style: TextStyle(color: Colors.white38, fontSize: 11, height: 1.35),
                  ),
                  const SizedBox(height: 8),
                  syncStatus.when(
                    loading: () => const Text('Syncing with cloud…',
                        style: TextStyle(color: AppColors.accentCyan, fontSize: 11)),
                    error: (_, __) => const Text(
                      'Cloud sync failed — data safe locally',
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                    data: (r) {
                      if (r == null) {
                        return const Text('Dual storage: local + Firebase',
                            style: TextStyle(color: Colors.white38, fontSize: 11));
                      }
                      if (r.skipped) {
                        return Text(
                          'Cloud: ${r.reason ?? 'offline'}',
                          style: const TextStyle(color: Colors.white38, fontSize: 11),
                        );
                      }
                      return Text(
                        'Cloud synced ↑${r.uploaded} ↓${r.downloaded}',
                        style: const TextStyle(
                            color: AppColors.accentGreen, fontSize: 11),
                      );
                    },
                  ),
                ],
              ),
            ),

            if (categoryData.isEmpty && merchants.isEmpty)
              GlassCard(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.only(top: 16),
                child: const Center(
                  child: Text(
                    'No spending data for this month',
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _hexColor(String hex) {
    try {
      return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return AppColors.accentPurple;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      );
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => GlassCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 6),
                Text(label,
                    style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      );
}
