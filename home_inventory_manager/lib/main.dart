import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_inventory_manager/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_inventory_manager/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_inventory_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_inventory_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/pages/login_page.dart';
import 'package:home_inventory_manager/features/auth/presentation/pages/register_page.dart';
import 'package:home_inventory_manager/features/home/presentation/pages/home_page.dart';
import 'package:home_inventory_manager/firebase_options.dart';
import 'package:home_inventory_manager/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(),
  );

  runApp(HomeInventoryApp(authRepository: authRepository));
}

class HomeInventoryApp extends StatelessWidget {
  const HomeInventoryApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: authRepository)..add(const AuthCheckRequested()),
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: HimTheme().getTheme(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (_) => const LoginPage(),
          RegisterPage.routeName: (_) => const RegisterPage(),
          HomePage.routeName: (_) => const HomePage(),
        },
      ),
    );
  }
}
