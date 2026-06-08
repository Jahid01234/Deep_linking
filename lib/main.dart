import 'package:deep_linking/app.dart';
import 'package:deep_linking/core/service_class/deep_link_service/deep_link_service.dart';
import 'package:deep_linking/core/service_class/push_notification_service/push_notification_service.dart';
import 'package:deep_linking/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  await DeepLinkService.instance.initialize();
  await FirebaseNotificationService.instance.initialize();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    // Foreground notification click handle
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null && response.payload!.isNotEmpty) {
        final Uri uri = Uri.parse(response.payload!);
        DeepLinkService.instance.handleDeepLink(uri);
      }
    },
  );

  runApp(const MyApp());
}
