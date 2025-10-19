import 'package:get/get.dart';
import 'package:simbiotik_getx_app/data/dataSource/api_client.dart';
import 'package:simbiotik_getx_app/data/repositories/auth_repository_implementation.dart';
import 'package:simbiotik_getx_app/presentation/controllers/auth_controllers.dart';
import '../data/repositories/meal_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/meal_repository.dart';
import '../presentation/controllers/meal_controller.dart';
import '../presentation/controllers/cart_controller.dart';

class DependencyInjection {
  static void init() {
    // Data Source
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    // Repository
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(), fenix: true);
    Get.lazyPut<MealRepository>(
      () => MealRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );

    // Controller
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<MealController>(
          () => MealController(Get.find<MealRepository>()),
      fenix: true,
    );
    Get.lazyPut<CartController>(
          () => CartController(),
      fenix: true,
    );
  }
}