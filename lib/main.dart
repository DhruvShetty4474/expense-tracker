import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'app/di/providers.dart';
import 'core/database/app_database.dart';
import 'services/notification/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await LocalNotificationService.instance.init();

  // Firebase.initializeApp requires google-services.json — configure via
  // FlutterFire CLI then uncomment:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final db = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
      child: const ExpenseTrackerApp(),
    ),
  );
}
