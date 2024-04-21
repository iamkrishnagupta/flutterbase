import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  static Future<void> initialize() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                if (message.notification != null) {
          log('Message title: ${message.notification!.title}');
        }
      });

      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      
      log('Messaging Authorized!');
    } else {
      log('User did not authorize messaging.');
    }
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  log('Background message title: ${message.notification?.title}');
}
