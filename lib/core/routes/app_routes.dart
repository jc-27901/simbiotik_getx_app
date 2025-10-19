import 'package:get/get.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/cart_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String cart = '/cart';

  static List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: cart,
      page: () => const CartPage(),
    ),
  ];
}