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
