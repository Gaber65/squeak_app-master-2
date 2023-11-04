import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  tz.initializeTimeZones();

  final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleMarchNotification({
  required String title,
  required String body,
}) async {
  const notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: 'some_payload',
  );
}
