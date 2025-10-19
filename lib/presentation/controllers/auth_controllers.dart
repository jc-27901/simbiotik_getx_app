import 'package:get/get.dart';
import 'package:simbiotik_getx_app/domain/entities/user_entities.dart';
import 'package:simbiotik_getx_app/domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final Rx<UserEntity?> _user = Rx<UserEntity?>(null);
  final RxBool _loading = false.obs;

  UserEntity? get user => _user.value;
  bool get isLoading => _loading.value;
  bool get isAuthenticated => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _user.value = _authRepository.getCurrentUser();
    _authRepository.authStateChanges.listen((user) {
      _user.value = user;
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      _loading.value = true;
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        Get.offAllNamed('/home');
        Get.snackbar('Success', 'Signed In Successfully');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign in failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _loading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _loading.value = true;
      await _authRepository.signOut();
      Get.offAllNamed('/login');
      Get.snackbar('Success', 'Signed Out Successfully');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign out failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _loading.value = false;
    }
  }
}
