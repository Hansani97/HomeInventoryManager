import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_manager/core/errors/auth_failure.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';
import 'package:home_inventory_manager/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthSocialLoginRequested>(_onSocialLoginRequested);
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearMessage: true));
    try {
      final user = await _authRepository.getCurrentUser();
      if (user == null) {
        emit(const AuthState.initial());
        return;
      }
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (_) {
      emit(const AuthState.initial());
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearMessage: true));
    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        message: 'Signed in successfully',
      ));
    } on AuthFailure catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, message: error.message));
    }
  }

  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearMessage: true));
    try {
      final user = await _authRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        message: 'Account created successfully',
      ));
    } on AuthFailure catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, message: error.message));
    }
  }

  Future<void> _onSocialLoginRequested(
    AuthSocialLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearMessage: true));
    emit(state.copyWith(
      status: AuthStatus.failure,
      message: '${event.provider} sign-in will be available in a future update.',
    ));
  }

  Future<void> _onForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.isEmpty || !event.email.contains('@')) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Enter a valid email address to reset your password.',
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, clearMessage: true));
    try {
      await _authRepository.sendPasswordResetEmail(event.email);
      emit(state.copyWith(
        status: AuthStatus.passwordResetSent,
        message: 'Password reset link sent to ${event.email}',
      ));
    } on AuthFailure catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, message: error.message));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(const AuthState.initial());
  }
}
