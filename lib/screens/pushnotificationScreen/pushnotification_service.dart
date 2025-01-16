import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushnotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    fcm.requestPermission();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        showNotification(message: message);
        print("On Message=======================>>>>>>>>>>>>>>>>>>>$message");
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        showNotification(message: message);
        print("On Message opened app=======================>>>>>>>>>>>>>>>>>>>$message");
      },
    );
  }

  showNotification({RemoteMessage? message}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      colorized: true,
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      playSound: true,
    );
    await _flutterLocalNotificationsPlugin.show(
        message?.data.hashCode ?? 11,
        message?.notification?.title ?? "WLF Pratik",
        message?.notification?.body ?? "HEllo Good Morning",
        NotificationDetails(
          android: androidDetails,
        ));
  }
}
