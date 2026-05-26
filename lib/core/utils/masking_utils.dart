class MaskingUtils {
  /// Masks account number: shows only last 4 digits → XX1234
  static String maskAccountNumber(String account) {
    if (account.length <= 4) return account;
    final last4 = account.substring(account.length - 4);
    return 'XX$last4';
  }

  /// Masks UPI ID: user****@bank
  static String maskUpiId(String upi) {
    final atIdx = upi.indexOf('@');
    if (atIdx <= 0) return '****';
    final prefix = upi.substring(0, upi.length > 4 ? 4 : upi.length);
    final domain = atIdx < upi.length ? upi.substring(atIdx) : '';
    return '$prefix****$domain';
  }

  /// Masks card number: shows only last 4 digits
  static String maskCardNumber(String card) {
    final clean = card.replaceAll(RegExp(r'\D'), '');
    if (clean.length < 4) return '****';
    return '**** **** **** ${clean.substring(clean.length - 4)}';
  }

  /// Masks phone number: +91 XXXXX 67890
  static String maskPhone(String phone) {
    if (phone.length < 5) return '****';
    final last5 = phone.substring(phone.length - 5);
    return '${phone.substring(0, phone.length - 10)}XXXXX$last5';
  }

  /// Strips reference numbers to safe form (last 6 chars only)
  static String sanitizeRefNumber(String ref) {
    if (ref.length <= 6) return ref;
    return '...${ref.substring(ref.length - 6)}';
  }
}
