part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  failure,
  passwordResetSent,
}

final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    this.message,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);

  final AuthStatus status;
  final AppUser? user;
  final String? message;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    String? message,
    bool clearUser = false,
    bool clearMessage = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
