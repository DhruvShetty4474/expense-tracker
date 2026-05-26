import 'package:intl/intl.dart';

class AppDateUtils {
  static final DateFormat _display = DateFormat('dd MMM yyyy');
  static final DateFormat _displayShort = DateFormat('dd MMM');
  static final DateFormat _displayTime = DateFormat('dd MMM, hh:mm a');
  static final DateFormat _monthYear = DateFormat('MMM yyyy');

  static String toDisplay(DateTime date) => _display.format(date);
  static String toDisplayShort(DateTime date) => _displayShort.format(date);
  static String toDisplayWithTime(DateTime date) => _displayTime.format(date);
  static String toMonthYear(DateTime date) => _monthYear.format(date);

  static int toYYYYMM(DateTime date) => date.year * 100 + date.month;

  static DateTime startOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  static DateTime endOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0, 23, 59, 59);

  static DateTime startOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;

  static bool isToday(DateTime date) => isSameDay(date, DateTime.now());

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String relativeLabel(DateTime date) {
    final now = DateTime.now();
    if (isSameDay(date, now)) return 'Today';
    if (isSameDay(date, now.subtract(const Duration(days: 1)))) return 'Yesterday';
    return toDisplay(date);
  }
}
