import 'package:deep_linking/core/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deep Linking',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
