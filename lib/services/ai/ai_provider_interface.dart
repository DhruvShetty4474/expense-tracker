import '../../shared/models/chat_message.dart';

/// Sanitized financial snapshot sent to AI — NO raw SMS, account numbers, or OTPs.
class FinancialContext {
  final double monthlyIncome;
  final double totalSpentThisMonth;
  final double previousMonthSpent;
  final Map<String, double> spendingByCategory;
  final List<String> recentMerchants;
  final Map<String, double> topMerchants;
  final double savingsRate;
  final Map<String, ({double budget, double spent})> budgetVsActual;
  final String userQuery;

  const FinancialContext({
    required this.monthlyIncome,
    required this.totalSpentThisMonth,
    this.previousMonthSpent = 0,
    required this.spendingByCategory,
    required this.recentMerchants,
    this.topMerchants = const {},
    required this.savingsRate,
    this.budgetVsActual = const {},
    required this.userQuery,
  });

  double get netSavings => monthlyIncome - totalSpentThisMonth;

  double? get spendingChangePct {
    if (previousMonthSpent <= 0) return null;
    return ((totalSpentThisMonth - previousMonthSpent) / previousMonthSpent) * 100;
  }

  String get patternSummary {
    final lines = <String>[];
    final change = spendingChangePct;
    if (change != null) {
      lines.add(
        'Spending vs last month: ${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
      );
    }
    if (topMerchants.isNotEmpty) {
      final top = topMerchants.entries.take(5).map(
            (e) => '${e.key}: ₹${e.value.toStringAsFixed(0)}',
          );
      lines.add('Top merchants: ${top.join(', ')}');
    }
    if (budgetVsActual.isNotEmpty) {
      final over = budgetVsActual.entries.where((e) => e.value.spent > e.value.budget);
      if (over.isNotEmpty) {
        lines.add(
          'Over budget: ${over.map((e) => '${e.key} (+₹${(e.value.spent - e.value.budget).toStringAsFixed(0)})').join(', ')}',
        );
      }
    }
    return lines.join('\n');
  }

  String get budgetSummary {
    if (budgetVsActual.isEmpty) return 'No budgets set yet.';
    return budgetVsActual.entries
        .map((e) =>
            '  ${e.key}: spent ₹${e.value.spent.toStringAsFixed(0)} / budget ₹${e.value.budget.toStringAsFixed(0)}')
        .join('\n');
  }

  String toPromptContext() {
    final categories = spendingByCategory.entries
        .map((e) => '  ${e.key}: ₹${e.value.toStringAsFixed(0)}')
        .join('\n');
    return '''
Monthly income: ₹${monthlyIncome.toStringAsFixed(0)}
Total spent this month: ₹${totalSpentThisMonth.toStringAsFixed(0)}
Net savings: ₹${netSavings.toStringAsFixed(0)}
Savings rate: ${(savingsRate * 100).toStringAsFixed(1)}%
Spending by category:
$categories
Recent merchants: ${recentMerchants.take(10).join(', ')}
$patternSummary
Budget vs actual:
$budgetSummary
''';
  }
}

abstract class AiProviderInterface {
  Stream<String> chat(
    String systemPrompt,
    List<ChatMessage> messages,
  );

  Future<String> generateInsight(FinancialContext context);

  Future<String> suggestBudgets(FinancialContext context);

  void dispose();
}
