import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/constants/app_constants.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    // Create notification channels (Android 8+)
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          AppConstants.budgetChannelId,
          'Budget Alerts',
          description: 'Notifications when you approach or exceed a budget limit',
          importance: Importance.high,
        ));

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          AppConstants.emiChannelId,
          'EMI Reminders',
          description: 'Upcoming EMI and subscription reminders',
          importance: Importance.defaultImportance,
        ));

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          AppConstants.insightChannelId,
          'AI Insights',
          description: 'Weekly financial insights from FinAI',
          importance: Importance.low,
        ));

    _initialized = true;
  }

  Future<void> showBudgetAlert({
    required String categoryName,
    required double percentUsed,
    required double spent,
    required double budget,
  }) async {
    final isOver = percentUsed >= 1.0;
    final title = isOver
        ? '🚨 Budget exceeded: $categoryName'
        : '⚠️ Budget alert: $categoryName';
    final body = isOver
        ? 'You\'ve spent ₹${spent.toStringAsFixed(0)} — ₹${(spent - budget).toStringAsFixed(0)} over your ₹${budget.toStringAsFixed(0)} limit'
        : 'You\'ve used ${(percentUsed * 100).toStringAsFixed(0)}% of your ₹${budget.toStringAsFixed(0)} budget';

    await _show(
      id: categoryName.hashCode,
      title: title,
      body: body,
      channelId: AppConstants.budgetChannelId,
      channelName: 'Budget Alerts',
    );
  }

  Future<void> showInsight({
    required String title,
    required String body,
  }) async {
    await _show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      channelId: AppConstants.insightChannelId,
      channelName: 'AI Insights',
    );
  }

  Future<void> _show({
    required int id,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> cancelAll() => _plugin.cancelAll();
}
