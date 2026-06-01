import 'package:uuid/uuid.dart';
import '../../core/utils/masking_utils.dart';
import '../../shared/enums/transaction_type.dart';
import '../../shared/enums/transaction_source.dart';
import '../../shared/models/transaction.dart';

/// Local on-device SMS parser — extracts structured data from Indian banking SMS.
/// Raw SMS text is NEVER stored; only the parsed Transaction entity is saved.
class SmsParser {
  static final _uuid = Uuid();

  // Amount patterns — handles ₹, Rs., INR with comma formatting
  static final _amountRe = RegExp(
    r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)',
    caseSensitive: false,
  );

  static final _debitRe = RegExp(
    r'\b(debited|debit|spent|paid|payment of|purchase|withdrawn|deducted)\b',
    caseSensitive: false,
  );

  static final _creditRe = RegExp(
    r'\b(credited|credit|received|salary|refund|cashback|deposited)\b',
    caseSensitive: false,
  );

  static final _merchantRe = RegExp(
    r'(?:at|to|@|merchant[:\s]+|vendor[:\s]+)\s*([A-Za-z0-9 &\-_\.]+?)(?:\s+on|\s+for|\s+via|\s+ref|\.|\n|$)',
    caseSensitive: false,
  );

  /// UPI debit pattern: "trf to Sainath Chinese Refno ..."
  static final _upiMerchantRe = RegExp(
    r"trf\s+to\s+([A-Za-z0-9 \-_.']+?)(?:\s+Ref|\s+ref|\s+If\b|\s+on\b|\n|$)",
    caseSensitive: false,
  );

  static final _refRe = RegExp(
    r'(?:ref(?:erence)?\.?\s*(?:no\.?)?|txn\.?\s*id)[:\s]*([A-Za-z0-9]+)',
    caseSensitive: false,
  );

  static final _otpRe = RegExp(
    r'\b(OTP|one.?time.?password|verification code)\b',
    caseSensitive: false,
  );

  static final _promoRe = RegExp(
    r'\b(offer|discount|cashback %|sale|promo|voucher|coupon|deal)\b',
    caseSensitive: false,
  );

  /// Returns null if SMS is not a parseable financial transaction.
  Transaction? parse(String smsBody, DateTime timestamp) {
    // Hard reject OTPs and promotions — never parse these
    if (_otpRe.hasMatch(smsBody)) return null;
    if (_promoRe.hasMatch(smsBody)) return null;

    final amountMatch = _amountRe.firstMatch(smsBody);
    if (amountMatch == null) return null;

    final amountStr = amountMatch.group(1)!.replaceAll(',', '');
    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) return null;

    final type = _debitRe.hasMatch(smsBody)
        ? TransactionType.debit
        : _creditRe.hasMatch(smsBody)
            ? TransactionType.credit
            : null;
    if (type == null) return null;

    final upiMatch = _upiMerchantRe.firstMatch(smsBody);
    final merchantMatch = _merchantRe.firstMatch(smsBody);
    final rawMerchant =
        upiMatch?.group(1)?.trim() ?? merchantMatch?.group(1)?.trim();

    final refMatch = _refRe.firstMatch(smsBody);
    final rawRef = refMatch?.group(1);

    return Transaction(
      id: _uuid.v4(),
      amount: amount,
      type: type,
      categoryId: 'cat_other',   // MerchantDetector will refine this
      timestamp: timestamp,
      source: TransactionSource.sms,
      merchant: rawMerchant,
      refNumber: rawRef != null ? MaskingUtils.sanitizeRefNumber(rawRef) : null,
    );
  }
}
