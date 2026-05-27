import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

/// Reads recent inbox SMS on-device for salary day detection.
class SmsInboxReader {
  final Telephony _telephony = Telephony.instance;

  Future<bool> hasPermission() async {
    if (!Platform.isAndroid) return false;
    return Permission.sms.isGranted;
  }

  Future<bool> requestPermission() async {
    if (!Platform.isAndroid) return false;
    final status = await Permission.sms.request();
    return status.isGranted;
  }

  Future<List<({String body, DateTime date})>> fetchRecent({
    int limit = 300,
  }) async {
    if (!Platform.isAndroid || !await hasPermission()) return [];

    final messages = await _telephony.getInboxSms(
      columns: [SmsColumn.BODY, SmsColumn.DATE],
      sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
    );

    return messages.take(limit).map((sms) {
      final millis = sms.date is int ? sms.date as int : 0;
      return (
        body: sms.body ?? '',
        date: DateTime.fromMillisecondsSinceEpoch(millis),
      );
    }).where((m) => m.body.isNotEmpty).toList();
  }
}
