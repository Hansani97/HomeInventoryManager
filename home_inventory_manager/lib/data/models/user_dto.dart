import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  static const collectionName = 'users';

  factory UserDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserDto(
      id: doc.id,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      phone: data['phone'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  factory UserDto.fromEntity(AppUser entity) {
    return UserDto(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as String,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      phone: map['phone'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  AppUser toEntity() {
    return AppUser(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      createdAt: createdAt,
    );
  }
}
