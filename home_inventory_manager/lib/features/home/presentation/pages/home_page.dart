import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/pages/login_page.dart';
import 'package:home_inventory_manager/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.homeInventory),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthSignOutRequested());
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                icon: const Icon(Icons.logout),
                tooltip: l10n.signOut,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.huge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.welcomeUser(user?.firstName ?? l10n.userFallback),
                  style: HimTextStyles.homeTitle,
                ),
                const SizedBox(height: Dimensions.md),
                Text(user?.email ?? '', style: HimTextStyles.homeEmail),
                const SizedBox(height: Dimensions.huge),
                Text(l10n.signedInDashboardSoon, style: HimTextStyles.homeBody),
              ],
            ),
          ),
        );
      },
    );
  }
}
