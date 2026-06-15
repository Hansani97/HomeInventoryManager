import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_inventory_manager/features/auth/presentation/pages/register_page.dart';
import 'package:home_inventory_manager/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_inventory_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_inventory_manager/features/auth/presentation/widgets/social_login_button.dart';
import 'package:home_inventory_manager/features/home/presentation/pages/home_page.dart';
import 'package:home_inventory_manager/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
          AuthLoginSubmitted(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  void _showForgotPasswordDialog(AppLocalizations l10n) {
    final emailController = TextEditingController(text: _emailController.text.trim());

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.forgotPasswordTitle),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: l10n.emailAddress,
            hintText: l10n.emailHint,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(
                    AuthForgotPasswordRequested(email: emailController.text.trim()),
                  );
            },
            child: Text(l10n.sendLink),
          ),
        ],
      ),
    ).then((_) => emailController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
          return;
        }

        if (state.message == null) return;
        final messenger = ScaffoldMessenger.of(context);
        if (state.status == AuthStatus.failure) {
          messenger.showSnackBar(
            SnackBar(content: Text(state.message!), backgroundColor: HimColors.error),
          );
        } else if (state.status == AuthStatus.passwordResetSent) {
          messenger.showSnackBar(
            SnackBar(content: Text(state.message!), backgroundColor: HimColors.primary),
          );
        }
      },
      child: Scaffold(
        backgroundColor: HimColors.primary,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: Dimensions.top),
              _buildHeader(l10n),
              Expanded(child: _buildFormCard(context, l10n)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: Dimensions.screenPadding,
      child: Column(
        children: [
          Container(
            width: Dimensions.logoOuter,
            height: Dimensions.logoOuter,
            decoration: BoxDecoration(
              color: HimColors.white,
              borderRadius: BorderRadius.circular(Dimensions.radiusCard),
            ),
            child: Center(
              child: Container(
                width: Dimensions.logoInner,
                height: Dimensions.logoInner,
                decoration: BoxDecoration(
                  color: HimColors.primary,
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                child: const Icon(
                  Icons.home_rounded,
                  color: HimColors.white,
                  size: FontSizes.iconMd,
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimensions.md),
          Text(l10n.homeInventory, style: HimTextStyles.splashTitle),
          const SizedBox(height: Dimensions.md),
          Text(l10n.tagline, textAlign: TextAlign.center, style: HimTextStyles.splashSubtitle),
          const SizedBox(height: Dimensions.header),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: HimColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSheetLg)),
      ),
      padding: Dimensions.cardPadding,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.welcomeBack, style: HimTextStyles.cardTitle),
              const SizedBox(height: Dimensions.sm),
              Text(l10n.signInToAccount, style: HimTextStyles.cardSubtitle),
              const SizedBox(height: Dimensions.xxxl),
              AuthTextField(
                label: l10n.emailAddress,
                hint: l10n.emailHint,
                icon: Icons.mail_outline,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return l10n.emailRequired;
                  if (!value.contains('@')) return l10n.emailInvalid;
                  return null;
                },
              ),
              const SizedBox(height: Dimensions.xxl),
              AuthTextField(
                label: l10n.password,
                hint: l10n.passwordHint,
                icon: Icons.lock_outline,
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.passwordRequired;
                  if (value.length < 6) return l10n.passwordMinLengthLogin;
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showForgotPasswordDialog(l10n),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: Dimensions.xs),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(l10n.forgotPassword, style: HimTextStyles.linkAction),
                ),
              ),
              const SizedBox(height: Dimensions.md),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return AuthPrimaryButton(
                    label: l10n.signIn,
                    isLoading: state.status == AuthStatus.loading,
                    onPressed: _submit,
                  );
                },
              ),
              const SizedBox(height: Dimensions.xxl),
              _buildDivider(l10n),
              const SizedBox(height: Dimensions.xxl),
              Row(
                children: [
                  SocialLoginButton(
                    label: l10n.google,
                    icon: Icons.g_mobiledata,
                    iconColor: HimColors.googleRed,
                    onPressed: () => context.read<AuthBloc>().add(
                          const AuthSocialLoginRequested(provider: 'Google'),
                        ),
                  ),
                  const SizedBox(width: Dimensions.md),
                  SocialLoginButton(
                    label: l10n.apple,
                    icon: Icons.apple,
                    iconColor: HimColors.primaryDeep,
                    onPressed: () => context.read<AuthBloc>().add(
                          const AuthSocialLoginRequested(provider: 'Apple'),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.xl),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: l10n.noAccount,
                    style: HimTextStyles.linkMuted,
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, RegisterPage.routeName),
                          child: Text(l10n.createOne, style: HimTextStyles.linkAction),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(AppLocalizations l10n) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
          child: Text(l10n.orContinueWith, style: HimTextStyles.divider),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
