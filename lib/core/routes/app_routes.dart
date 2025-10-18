import 'package:get/get.dart';
import 'package:simbiotik_getx_app/presentation/pages/home_page.dart';
import 'package:simbiotik_getx_app/presentation/pages/login_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomePage()),
  ];
}
