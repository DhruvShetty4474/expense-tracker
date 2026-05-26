import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../providers/analytics_providers.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final categoryData = ref.watch(categorySpendingEnrichedProvider);
    final dailyData = ref.watch(dailySpendingProvider);
    final monthlySpent = ref.watch(monthlySpendingProvider).valueOrNull ?? 0;
    final monthlyIncome = ref.watch(monthlyIncomeProvider).valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('Analytics'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          // Month summary
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Spent',
                          style: TextStyle(color: Colors.white54, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.formatCompact(monthlySpent),
                        style: const TextStyle(
                            color: AppColors.expense,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GlassCard(
                  margin: const EdgeInsets.only(left: 6),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Income',
                          style: TextStyle(color: Colors.white54, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.formatCompact(monthlyIncome),
                        style: const TextStyle(
                            color: AppColors.income,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Spending trend (line chart)
          if (dailyData.isNotEmpty) ...[
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('30-Day Spending Trend',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 160,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
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
                                return Text(
                                  '${d.day}/${d.month}',
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 10),
                                );
                              },
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: dailyData
                                .asMap()
                                .entries
                                .map((e) => FlSpot(
                                    e.key.toDouble(), e.value.amount))
                                .toList(),
                            isCurved: true,
                            color: AppColors.accentPurple,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.accentPurple.withValues(alpha: 0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Category breakdown (pie + list)
          if (categoryData.isNotEmpty) ...[
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Spending by Category',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            setState(() {
                              if (response?.touchedSection != null) {
                                _touchedIndex = response!
                                    .touchedSection!.touchedSectionIndex;
                              } else {
                                _touchedIndex = null;
                              }
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
                            radius: isTouched ? 55 : 45,
                            title: isTouched
                                ? '${(item.pct * 100).toStringAsFixed(0)}%'
                                : '',
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...categoryData.take(6).map((item) {
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
          ] else ...[
            GlassCard(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Text(
                  'No spending data this month',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ),
          ],
        ],
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
