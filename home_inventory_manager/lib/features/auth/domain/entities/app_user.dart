import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.createdAt,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final DateTime createdAt;

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [id, email, firstName, lastName, phone, createdAt];
}
