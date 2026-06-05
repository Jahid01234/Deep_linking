import 'package:deep_linking/feature/home/view/home_screen.dart';
import 'package:deep_linking/feature/product/view/product_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  // Route names
  static const String home = '/home';
  static const String product = '/product';

  // Routes list
  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: product,
      page: () => const ProductScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}