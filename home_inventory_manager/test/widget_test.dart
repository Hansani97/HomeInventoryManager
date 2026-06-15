import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_inventory_manager/features/auth/domain/entities/app_user.dart';
import 'package:home_inventory_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_inventory_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/pages/login_page.dart';
import 'package:home_inventory_manager/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<AppUser> login({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<AppUser> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> getCurrentUser() async => null;

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('Login page renders welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HimTheme().getTheme(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => AuthBloc(authRepository: FakeAuthRepository()),
          child: const LoginPage(),
        ),
      ),
    );

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });
}
