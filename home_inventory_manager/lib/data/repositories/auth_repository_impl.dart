import 'package:home_inventory_manager/data/datasources/auth_local_datasource.dart';
import 'package:home_inventory_manager/data/datasources/auth_remote_datasource.dart';
import 'package:home_inventory_manager/data/models/user_dto.dart';
import 'package:home_inventory_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<AppUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final user = await _remoteDataSource.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    );
    await _localDataSource.saveUser(UserDto.fromEntity(user));
    return user;
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final user = await _remoteDataSource.login(email: email, password: password);
    await _localDataSource.saveUser(UserDto.fromEntity(user));
    return user;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final userId = _remoteDataSource.currentUserId;
    if (userId == null) return null;

    final remoteUser = await _remoteDataSource.getCurrentUser();
    if (remoteUser != null) {
      await _localDataSource.saveUser(UserDto.fromEntity(remoteUser));
      return remoteUser;
    }

    return _localDataSource.getUser(userId);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() async {
    final userId = _remoteDataSource.currentUserId;
    await _remoteDataSource.signOut();
    if (userId != null) {
      await _localDataSource.deleteUser(userId);
    }
  }
}
