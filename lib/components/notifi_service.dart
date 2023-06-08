import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final android = AndroidNotificationDetails;

  static Future notificationsDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationsDetail(),
      payload: payload,
    );
  }
}
