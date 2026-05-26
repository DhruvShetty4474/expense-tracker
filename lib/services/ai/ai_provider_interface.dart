import '../../shared/models/chat_message.dart';

/// Sanitized financial snapshot sent to AI — NO raw SMS, account numbers, or OTPs.
class FinancialContext {
  final double monthlyIncome;
  final double totalSpentThisMonth;
  final Map<String, double> spendingByCategory;
  final List<String> recentMerchants;
  final double savingsRate;
  final String userQuery;

  const FinancialContext({
    required this.monthlyIncome,
    required this.totalSpentThisMonth,
    required this.spendingByCategory,
    required this.recentMerchants,
    required this.savingsRate,
    required this.userQuery,
  });

  String toPromptContext() {
    final categories = spendingByCategory.entries
        .map((e) => '  ${e.key}: ₹${e.value.toStringAsFixed(0)}')
        .join('\n');
    return '''
Monthly income: ₹${monthlyIncome.toStringAsFixed(0)}
Total spent this month: ₹${totalSpentThisMonth.toStringAsFixed(0)}
Savings rate: ${(savingsRate * 100).toStringAsFixed(1)}%
Spending by category:
$categories
Recent merchants: ${recentMerchants.take(10).join(', ')}
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
