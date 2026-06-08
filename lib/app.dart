import 'package:deep_linking/core/route/routes.dart';
import 'package:deep_linking/core/service_class/deep_link_service/deep_link_service.dart';
import 'package:deep_linking/feature/notification_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deep Linking',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onReady: () {
        // ✅ App সম্পূর্ণ ready হওয়ার পরে navigate করো
        final pending = NotificationNavigator.pendingDeepLink;
        if (pending != null && pending.isNotEmpty) {
          final Uri uri = Uri.parse(pending);
          DeepLinkService.instance.handleDeepLink(uri);
          NotificationNavigator.pendingDeepLink = null;
        }
      },
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
