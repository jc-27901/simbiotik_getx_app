import 'package:simbiotik_getx_app/domain/entities/user_entities.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<void> signOut();
  UserEntity? getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
}