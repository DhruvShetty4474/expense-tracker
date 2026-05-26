class AppConstants {
  static const String appName = 'FinAI';
  static const String currency = '₹';
  static const String currencyCode = 'INR';
  static const String locale = 'en_IN';

  // Drift DB
  static const String dbName = 'expense_tracker.db';
  static const int dbVersion = 1;

  // Pagination
  static const int pageSize = 20;

  // Budget alert threshold (90%)
  static const double budgetAlertThreshold = 0.9;

  // AI context limits
  static const int maxMerchantsInContext = 10;
  static const int maxInsightAgeInDays = 7;

  // Secure storage keys
  static const String dbEncryptionKey = 'db_enc_key';
  static const String biometricEnabledKey = 'biometric_enabled';

  // Notification channels
  static const String budgetChannelId = 'budget_alerts';
  static const String emiChannelId = 'emi_reminders';
  static const String insightChannelId = 'ai_insights';
  static const String generalChannelId = 'general';

  // Route names
  static const String routeSplash = '/';
  static const String routeAuth = '/auth';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeTransactions = '/transactions';
  static const String routeAddTransaction = '/transactions/add';
  static const String routeEditTransaction = '/transactions/edit';
  static const String routeSmsReview = '/sms-review';
  static const String routeAnalytics = '/analytics';
  static const String routeAiChat = '/ai-chat';
  static const String routeBudgets = '/budgets';
  static const String routeSavingsGoals = '/savings-goals';
  static const String routeSettings = '/settings';
  static const String routePrivacyDashboard = '/privacy';
  static const String routeProfile = '/profile';
}
