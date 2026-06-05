import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:deep_linking/core/route/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService instance = DeepLinkService._();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _linkSubscription;

  Future<void> initialize() async {
    // App terminated থেকে deep link দিয়ে open হলে
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        if (kDebugMode) print("Initial Deep Link: $initialLink");
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      if (kDebugMode) print("Initial Deep Link Error: $e");
    }

    // App background/foreground এ থাকলে
    _linkSubscription = _appLinks.uriLinkStream.listen(
          (Uri uri) {
        if (kDebugMode) print("Deep Link Received: $uri");
        _handleDeepLink(uri);
      },
      onError: (err) {
        if (kDebugMode) print("Deep Link Stream Error: $err");
      },
    );
  }

  void handleDeepLink(Uri uri) {
    _handleDeepLink(uri);
  }

  void _handleDeepLink(Uri uri) {
    if (kDebugMode) {
      print("Scheme: ${uri.scheme}");
      print("Host: ${uri.host}");
      print("Path: ${uri.path}");
      print("Params: ${uri.queryParameters}");
    }

    // myapp://product → ProductScreen
    if (uri.host == 'product') {
      Get.toNamed(AppRoutes.product);
    }

    // আরো screen add করতে পারো এখানে
    // else if (uri.host == 'order') {
    //   Get.toNamed(AppRoutes.order);
    // }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}