import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });

  Future<AppUser> login({
    required String email,
    required String password,
  });

  Future<AppUser?> getCurrentUser();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
