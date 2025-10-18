import 'package:get/get.dart';
import 'package:simbiotik_getx_app/data/repositories/auth_repository_implementation.dart';
import 'package:simbiotik_getx_app/domain/repositories/auth_repository.dart';
import 'package:simbiotik_getx_app/presentation/controllers/auth_controllers.dart';

class DependencyInjection {
  static void init() {
    // Repository
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(), fenix: true);

    // Controller
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthRepository>()),
      fenix: true,
    );
  }
}
