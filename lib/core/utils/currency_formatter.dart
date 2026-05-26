import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: AppConstants.locale,
    symbol: AppConstants.currency,
    decimalDigits: 2,
  );

  static final NumberFormat _compact = NumberFormat.compactCurrency(
    locale: AppConstants.locale,
    symbol: AppConstants.currency,
    decimalDigits: 1,
  );

  static String format(double amount) => _formatter.format(amount);

  static String formatCompact(double amount) => _compact.format(amount);

  static String formatNoSymbol(double amount) =>
      NumberFormat('#,##,##0.00', AppConstants.locale).format(amount);
}
