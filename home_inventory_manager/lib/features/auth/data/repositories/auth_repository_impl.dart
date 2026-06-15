import 'package:home_inventory_manager/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';
import 'package:home_inventory_manager/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AppUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) {
    return _remoteDataSource.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<AppUser?> getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }
}
