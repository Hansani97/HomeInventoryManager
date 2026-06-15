import 'package:home_inventory_manager/data/models/user_dto.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({required Database database}) : _database = database;

  final Database _database;

  static const _tableUsers = 'users';

  Future<void> saveUser(UserDto user) async {
    await _database.insert(
      _tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AppUser?> getUser(String id) async {
    final rows = await _database.query(
      _tableUsers,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return UserDto.fromMap(rows.first).toEntity();
  }

  Future<void> deleteUser(String id) async {
    await _database.delete(
      _tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearUsers() async {
    await _database.delete(_tableUsers);
  }
}
