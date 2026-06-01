import 'sms_parser.dart';
import '../../shared/enums/transaction_type.dart';

/// Result of auto-detecting salary credits from SMS inbox.
class SalaryDetectionResult {
  final String? creditorAccount;
  final double? latestAmount;
  final int dayStart;
  final int dayEnd;
  final int matchCount;
  final String? sampleSnippet;

  const SalaryDetectionResult({
    this.creditorAccount,
    this.latestAmount,
    required this.dayStart,
    required this.dayEnd,
    required this.matchCount,
    this.sampleSnippet,
  });

  bool get isRange => dayStart != dayEnd;

  String dayRangeLabel(String Function(int) ordinal) {
    if (isRange) {
      return '${ordinal(dayStart)} – ${ordinal(dayEnd)} of every month';
    }
    return '${ordinal(dayStart)} of every month';
  }
}

/// Detects salary credit windows from local SMS using creditor identity,
/// not fixed amounts (handles salary hikes).
class SalaryDayDetector {
  static final _salaryKeywords = RegExp(
    r'\b(salary|sal\b|payroll|wages|stipend|pay\s*credit|monthly\s*pay)\b',
    caseSensitive: false,
  );

  static final _creditTransfer = RegExp(
    r'\b(credited|credit|received|deposited|neft\s*cr|imps\s*cr|rtgs\s*cr|upi\s*cr)\b',
    caseSensitive: false,
  );

  /// e.g. "by a/c linked to mobile 8XXXXXX093-ARKAINFOTE"
  static final _creditorRe = RegExp(
    r'by\s+a/c\s+linked\s+to\s+mobile\s+[0-9X\-]+-([A-Za-z0-9]+)',
    caseSensitive: false,
  );

  /// e.g. "credited ... on 02-04-26" or "on date 14May26"
  static final _smsDateRe = RegExp(
    r'\bon\s+(?:date\s+)?(\d{1,2})[-/](\d{1,2})[-/](\d{2,4})|\bon\s+date\s+(\d{1,2})([A-Za-z]{3})(\d{2,4})',
    caseSensitive: false,
  );

  static final _amountRe = RegExp(
    r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)',
    caseSensitive: false,
  );

  /// Returns true when an SMS likely represents a salary credit.
  static bool isSalarySms(String body, {String? creditorHint}) {
    if (_salaryKeywords.hasMatch(body)) return true;
    if (!_creditTransfer.hasMatch(body)) return false;

    final creditor = extractCreditor(body);
    if (creditor != null && creditorHint != null &&
        _normalizeCreditor(creditor) == _normalizeCreditor(creditorHint)) {
      return true;
    }

    return creditor != null;
  }

  static String? extractCreditor(String body) {
    final m = _creditorRe.firstMatch(body);
    return m?.group(1)?.trim();
  }

  static String _normalizeCreditor(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

  static int? _dayFromSmsBody(String body, DateTime fallback) {
    final m = _smsDateRe.firstMatch(body);
    if (m == null) return fallback.day;

    if (m.group(1) != null) {
      return int.tryParse(m.group(1)!);
    }
    if (m.group(4) != null) {
      return int.tryParse(m.group(4)!);
    }
    return fallback.day;
  }

  static double? _amountFromBody(String body) {
    final m = _amountRe.firstMatch(body);
    if (m == null) return null;
    return double.tryParse(m.group(1)!.replaceAll(',', ''));
  }

  /// Detects salary window using recurring creditor credits across months.
  static SalaryDetectionResult? detectFromParsedSms(
    List<({String body, DateTime date})> messages,
  ) {
    final parser = SmsParser();
    final byCreditor = <String, List<({String body, DateTime date, int day, double? amount})>>{};

    for (final msg in messages) {
      final txn = parser.parse(msg.body, msg.date);
      if (txn == null || txn.type != TransactionType.credit) continue;

      final creditor = extractCreditor(msg.body);
      if (creditor == null && !_salaryKeywords.hasMatch(msg.body)) continue;
      if (!_creditTransfer.hasMatch(msg.body)) continue;

      final key = creditor != null
          ? _normalizeCreditor(creditor)
          : '_keyword_salary';
      final day = _dayFromSmsBody(msg.body, msg.date) ?? msg.date.day;
      final amount = _amountFromBody(msg.body);

      byCreditor.putIfAbsent(key, () => []);
      byCreditor[key]!.add((
        body: msg.body,
        date: msg.date,
        day: day.clamp(1, 31),
        amount: amount,
      ));
    }

    if (byCreditor.isEmpty) return _legacyDetect(messages);

    // Prefer creditor with most hits across distinct months.
    String? bestKey;
    var bestScore = 0;
    for (final e in byCreditor.entries) {
      final months = e.value.map((m) => '${m.date.year}-${m.date.month}').toSet();
      final score = e.value.length * 2 + months.length * 3;
      if (score > bestScore) {
        bestScore = score;
        bestKey = e.key;
      }
    }

    if (bestKey == null) return null;
    final hits = byCreditor[bestKey]!;
    if (hits.isEmpty) return null;

    hits.sort((a, b) => b.date.compareTo(a.date));
    final days = hits.map((h) => h.day).toList();
    final dayStart = days.reduce((a, b) => a < b ? a : b);
    final dayEnd = days.reduce((a, b) => a > b ? a : b);

    final creditorRaw = bestKey == '_keyword_salary'
        ? null
        : extractCreditor(hits.first.body) ?? hits.first.body;

    return SalaryDetectionResult(
      creditorAccount: creditorRaw != null && bestKey != '_keyword_salary'
          ? extractCreditor(hits.first.body) ?? creditorRaw
          : null,
      latestAmount: hits.first.amount,
      dayStart: dayStart,
      dayEnd: dayEnd,
      matchCount: hits.length,
      sampleSnippet: hits.first.body.length > 120
          ? '${hits.first.body.substring(0, 120)}…'
          : hits.first.body,
    );
  }

  /// Legacy single-day fallback (keyword + large credit).
  static SalaryDetectionResult? _legacyDetect(
    List<({String body, DateTime date})> messages,
  ) {
    final dayCounts = <int, int>{};
    String? sample;
    double? amount;

    for (final msg in messages) {
      if (!isSalarySms(msg.body)) continue;
      final day = _dayFromSmsBody(msg.body, msg.date) ?? msg.date.day;
      dayCounts[day] = (dayCounts[day] ?? 0) + 1;
      sample ??= msg.body;
      amount ??= _amountFromBody(msg.body);
    }

    if (dayCounts.isEmpty) return null;

    final bestDay = dayCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    return SalaryDetectionResult(
      dayStart: bestDay,
      dayEnd: bestDay,
      matchCount: dayCounts[bestDay] ?? 1,
      latestAmount: amount,
      sampleSnippet: sample,
    );
  }

  /// Finds the most common day-of-month among salary-like SMS messages.
  static int? detectDay(List<({String body, DateTime date})> messages) {
    final result = detectFromParsedSms(messages);
    return result?.dayStart;
  }
}
