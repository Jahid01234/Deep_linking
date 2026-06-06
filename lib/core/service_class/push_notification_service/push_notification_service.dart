import 'package:deep_linking/core/service_class/deep_link_service/deep_link_service.dart';
import 'package:deep_linking/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseNotificationService {
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   FirebaseNotificationService._();
//   static final FirebaseNotificationService instance = FirebaseNotificationService._();
//
//   Future<void> initialize() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       sound: true,
//       badge: true,
//       announcement: false,
//       carPlay: false,
//       provisional: false,
//     );
//
//     // Foreground state
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       if (kDebugMode) {
//         print(message.notification?.title);
//       }
//       if (kDebugMode) {
//         print(message.notification?.body);
//       }
//       if (kDebugMode) {
//         print(message.data);
//       }
//
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       const AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // name
//         description: 'This channel is used for important notifications.', // description
//         importance: Importance.high,
//       );
//
//       if (notification != null && android != null) {
//         await flutterLocalNotificationsPlugin.show(
//           id: notification.hashCode,
//           title: notification.title,
//           body: notification.body,
//           notificationDetails: NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: android.smallIcon,
//             ),
//           ),
//         );
//       }
//
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     });
//
//     // Background state
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print(message.notification?.title);
//       }
//       if (kDebugMode) {
//         print(message.notification?.body);
//       }
//       if (kDebugMode) {
//         print(message.data);
//       }
//     });
//
//     // terminated state
//     FirebaseMessaging.onBackgroundMessage(doNothing);
//
//     // get token
//     String? token = await getToken();
//     if (kDebugMode) {
//       print(token);
//     }
//
//   }
//
//   // For use instant notification get(Locally)
//   Future<String?> getToken() async{
//     String? token = await _firebaseMessaging.getToken();
//     return token;
//   }
// }
//
//
// // Top_level function for (terminated state)
// Future<void> doNothing(RemoteMessage message) async{
//   if (kDebugMode) {
//     print(message.notification?.title);
//   }
//   if (kDebugMode) {
//     print(message.notification?.body);
//   }
//   if (kDebugMode) {
//     print(message.data);
//   }
// }



class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService._();
  static final FirebaseNotificationService instance = FirebaseNotificationService._();

  Future<void> initialize() async {
    // Permission
    await _firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: false,
      carPlay: false,
      provisional: false,
    );

    // Notification Channel তৈরি
    await _createNotificationChannel();

    // Foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("Foreground Title: ${message.notification?.title}");
        print("Foreground Body: ${message.notification?.body}");
        print("Foreground Data: ${message.data}");
      }

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription: 'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          // Deep link payload হিসেবে পাঠাও
          payload: message.data['deep_link'] ?? '',
        );
      }
    });

    // Background state — notification click
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Background Opened Title: ${message.notification?.title}");
        print("Background Opened Data: ${message.data}");
      }
      _navigateFromNotification(message.data);
    });

    // Terminated state handler
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    // Terminated state — app open হলে
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      if (kDebugMode) print("Terminated message: ${initialMessage.data}");
      // WidgetsBinding দিয়ে delay দাও যেন app ready হয়
      Future.delayed(const Duration(seconds: 1), () {
        _navigateFromNotification(initialMessage.data);
      });
    }

    // Token
    String? token = await getToken();
    if (kDebugMode) print("FCM Token: $token");
  }

  void _navigateFromNotification(Map<String, dynamic> data) {
    final String? deepLink = data['deep_link'];
    if (deepLink != null && deepLink.isNotEmpty) {
      final Uri uri = Uri.parse(deepLink);
      DeepLinkService.instance.handleDeepLink(uri);
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}

// Top-level function — terminated state
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Background Handler Title: ${message.notification?.title}");
    print("Background Handler Body: ${message.notification?.body}");
    print("Background Handler Data: ${message.data}");
  }
}