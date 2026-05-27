import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: AppConstants.locale,
    symbol: AppConstants.currency,
    decimalDigits: 2,
  );

  static String format(double amount) => _formatter.format(amount);

  /// Indian-friendly compact format without currency symbol.
  /// Avoids en_IN compactCurrency "T" (thousand) which reads like trillion.
  static String formatCompact(double amount) {
    final abs = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (abs < 1000) {
      return '$sign${abs.toStringAsFixed(abs == abs.roundToDouble() ? 0 : 2)}';
    }
    if (abs < 100000) {
      final value = abs / 1000;
      return '$sign${_trimTrailingZero(value.toStringAsFixed(value >= 10 ? 0 : 1))}K';
    }
    if (abs < 10000000) {
      final value = abs / 100000;
      return '$sign${_trimTrailingZero(value.toStringAsFixed(value >= 10 ? 1 : 2))}L';
    }
    final value = abs / 10000000;
    return '$sign${_trimTrailingZero(value.toStringAsFixed(2))}Cr';
  }

  static String formatNoSymbol(double amount) =>
      NumberFormat('#,##,##0.##', AppConstants.locale).format(amount);

  static String _trimTrailingZero(String value) {
    if (!value.contains('.')) return value;
    return value.replaceAll(RegExp(r'\.?0+$'), '');
  }
}
