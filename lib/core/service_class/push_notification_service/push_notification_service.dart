import 'package:deep_linking/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService._();
  static final FirebaseNotificationService instance = FirebaseNotificationService._();

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: false,
      carPlay: false,
      provisional: false,
    );

    // Foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print(message.notification?.title);
      }
      if (kDebugMode) {
        print(message.notification?.body);
      }
      if (kDebugMode) {
        print(message.data);
      }

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // name
        description: 'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    });

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(message.notification?.title);
      }
      if (kDebugMode) {
        print(message.notification?.body);
      }
      if (kDebugMode) {
        print(message.data);
      }
    });

    // terminated state
    FirebaseMessaging.onBackgroundMessage(doNothing);

    // get token
    String? token = await getToken();
    if (kDebugMode) {
      print(token);
    }

  }

  // For use instant notification get(Locally)
  Future<String?> getToken() async{
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}


// Top_level function for (terminated state)
Future<void> doNothing(RemoteMessage message) async{
  if (kDebugMode) {
    print(message.notification?.title);
  }
  if (kDebugMode) {
    print(message.notification?.body);
  }
  if (kDebugMode) {
    print(message.data);
  }
}