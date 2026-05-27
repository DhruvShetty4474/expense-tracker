import 'sms_parser.dart';

/// Detects the most likely salary credit day from local SMS messages.
/// Uses salary keywords, NEFT/IMPS credits, and recurring credit patterns.
class SalaryDayDetector {
  static final _salaryKeywords = RegExp(
    r'\b(salary|sal\b|payroll|wages|stipend|pay\s*credit|monthly\s*pay)\b',
    caseSensitive: false,
  );

  static final _creditTransfer = RegExp(
    r'\b(credited|credit|received|deposited|neft\s*cr|imps\s*cr|rtgs\s*cr|upi\s*cr)\b',
    caseSensitive: false,
  );

  static final _employerHints = RegExp(
    r'\b(employer|company|corp|pvt\s*ltd|limited|services|consulting|tech\s*solutions)\b',
    caseSensitive: false,
  );

  /// Returns true when an SMS likely represents a salary credit.
  static bool isSalarySms(String body) {
    if (_salaryKeywords.hasMatch(body)) return true;

    if (!_creditTransfer.hasMatch(body)) return false;

    // Large credits with employer-like merchant names are often salary.
    if (_employerHints.hasMatch(body)) return true;

    final amountMatch = RegExp(
      r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)',
      caseSensitive: false,
    ).firstMatch(body);
    if (amountMatch == null) return false;

    final amount =
        double.tryParse(amountMatch.group(1)!.replaceAll(',', '')) ?? 0;
    return amount >= 15000;
  }

  /// Finds the most common day-of-month among salary-like SMS messages.
  static int? detectDay(List<({String body, DateTime date})> messages) {
    final dayCounts = <int, int>{};

    for (final msg in messages) {
      if (!isSalarySms(msg.body)) continue;
      final day = msg.date.day;
      dayCounts[day] = (dayCounts[day] ?? 0) + 1;
    }

    if (dayCounts.isEmpty) return null;

    return dayCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  /// Parses SMS bodies via [SmsParser] and returns salary credit days.
  static int? detectFromParsedSms(
    List<({String body, DateTime date})> messages,
  ) {
    final parser = SmsParser();
    final dayCounts = <int, int>{};

    for (final msg in messages) {
      final txn = parser.parse(msg.body, msg.date);
      if (txn == null) continue;
      if (!isSalarySms(msg.body)) continue;
      final day = msg.date.day;
      dayCounts[day] = (dayCounts[day] ?? 0) + 1;
    }

    if (dayCounts.isEmpty) return detectDay(messages);

    return dayCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }
}
