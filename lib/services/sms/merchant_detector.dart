/// Maps raw merchant names from SMS to category IDs using a local lookup table.
/// User corrections are persisted in the merchant_mappings DB table.
class MerchantDetector {
  static const Map<String, String> _defaults = {
    // Food
    'zomato': 'cat_food',
    'swiggy': 'cat_food',
    'dominos': 'cat_food',
    'dominoz': 'cat_food',
    'pizza hut': 'cat_food',
    'kfc': 'cat_food',
    'mcdonalds': 'cat_food',
    'mcd': 'cat_food',
    'subway': 'cat_food',
    'blinkit': 'cat_food',
    'zepto': 'cat_food',
    'bigbasket': 'cat_food',
    'dunzo': 'cat_food',
    'instamart': 'cat_food',
    // Transport
    'uber': 'cat_transport',
    'ola': 'cat_transport',
    'rapido': 'cat_transport',
    'namma yatri': 'cat_transport',
    'irctc': 'cat_transport',
    'redbus': 'cat_transport',
    'makemytrip': 'cat_travel',
    'goibibo': 'cat_travel',
    'indigo': 'cat_travel',
    'air india': 'cat_travel',
    // Shopping
    'amazon': 'cat_shopping',
    'flipkart': 'cat_shopping',
    'myntra': 'cat_shopping',
    'ajio': 'cat_shopping',
    'nykaa': 'cat_shopping',
    'meesho': 'cat_shopping',
    'snapdeal': 'cat_shopping',
    'tata cliq': 'cat_shopping',
    // Entertainment
    'netflix': 'cat_subscription',
    'prime video': 'cat_subscription',
    'hotstar': 'cat_subscription',
    'disney': 'cat_subscription',
    'spotify': 'cat_subscription',
    'youtube premium': 'cat_subscription',
    'zee5': 'cat_subscription',
    'sonyliv': 'cat_subscription',
    'pvr': 'cat_entertainment',
    'inox': 'cat_entertainment',
    // Health
    'pharmeasy': 'cat_health',
    'netmeds': 'cat_health',
    '1mg': 'cat_health',
    'apollo': 'cat_health',
    'practo': 'cat_health',
    // Utilities
    'bses': 'cat_utilities',
    'tata power': 'cat_utilities',
    'adani electricity': 'cat_utilities',
    'airtel': 'cat_utilities',
    'jio': 'cat_utilities',
    'bsnl': 'cat_utilities',
    'vi ': 'cat_utilities',
    'vodafone': 'cat_utilities',
    'idea': 'cat_utilities',
    'act fibernet': 'cat_utilities',
  };

  /// User-defined overrides loaded from DB (merchantKey → categoryId).
  final Map<String, String> _userMappings;

  MerchantDetector({Map<String, String> userMappings = const {}})
      : _userMappings = userMappings;

  String categoryFor(String? merchant) {
    if (merchant == null) return 'cat_other';
    final key = merchant.toLowerCase().trim();

    // User corrections take priority
    if (_userMappings.containsKey(key)) return _userMappings[key]!;

    // Substring match against defaults
    for (final entry in _defaults.entries) {
      if (key.contains(entry.key)) return entry.value;
    }
    return 'cat_other';
  }
}
