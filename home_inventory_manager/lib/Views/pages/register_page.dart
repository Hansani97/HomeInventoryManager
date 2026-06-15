import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_inventory_manager/bloc/auth_bloc.dart';
import 'package:home_inventory_manager/Views/widgets/auth_primary_button.dart';
import 'package:home_inventory_manager/Views/widgets/auth_text_field.dart';
import 'package:home_inventory_manager/Views/widgets/password_strength_indicator.dart';
import 'package:home_inventory_manager/Views/pages/home_page.dart';
import 'package:home_inventory_manager/generated/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _acceptedTerms = false;
  PasswordStrength _passwordStrength = PasswordStrength.none;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations l10n) {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.acceptTermsRequired),
          backgroundColor: HimColors.error,
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          AuthRegisterSubmitted(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
          return;
        }

        if (state.message == null) return;
        final messenger = ScaffoldMessenger.of(context);
        if (state.status == AuthStatus.failure) {
          messenger.showSnackBar(
            SnackBar(content: Text(state.message!), backgroundColor: HimColors.error),
          );
        }
      },
      child: Scaffold(
        backgroundColor: HimColors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context, l10n),
              Expanded(child: _buildBody(context, l10n)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      color: HimColors.primary,
      padding: Dimensions.registerHeaderPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: FontSizes.lg, color: HimColors.primaryLight),
                const SizedBox(width: Dimensions.sm),
                Text(l10n.backToSignIn, style: HimTextStyles.backLink),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.xxl),
          Text(l10n.createAccount, style: HimTextStyles.registerTitle),
          const SizedBox(height: Dimensions.xs),
          Text(l10n.createAccountSubtitle, style: HimTextStyles.registerSubtitle),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    return Transform.translate(
      offset: const Offset(0, -Dimensions.lg),
      child: Container(
        decoration: const BoxDecoration(
          color: HimColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSheet)),
        ),
        padding: Dimensions.registerCardPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: Dimensions.xxxl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AuthTextField(
                        label: l10n.firstName,
                        hint: l10n.firstNameHint,
                        icon: Icons.person_outline,
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: Dimensions.md),
                    Expanded(
                      child: AuthTextField(
                        label: l10n.lastName,
                        hint: l10n.lastNameHint,
                        icon: Icons.person_outline,
                        controller: _lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.lg),
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
                  label: l10n.phoneNumber,
                  hint: l10n.phoneHint,
                  icon: Icons.phone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: Dimensions.xxl),
                AuthTextField(
                  label: l10n.password,
                  hint: l10n.passwordHint,
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() => _passwordStrength = evaluatePasswordStrength(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.passwordRequired;
                    if (value.length < 8) return l10n.passwordMinLengthRegister;
                    return null;
                  },
                ),
                PasswordStrengthIndicator(strength: _passwordStrength),
                const SizedBox(height: Dimensions.lg),
                AuthTextField(
                  label: l10n.confirmPassword,
                  hint: l10n.passwordHint,
                  icon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  suffixIcon: _confirmPasswordController.text.isNotEmpty &&
                          _confirmPasswordController.text == _passwordController.text
                      ? const Icon(Icons.check, size: FontSizes.iconSm, color: HimColors.primary)
                      : null,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.confirmPasswordRequired;
                    if (value != _passwordController.text) return l10n.passwordsDoNotMatch;
                    return null;
                  },
                ),
                const SizedBox(height: Dimensions.xl),
                _buildTermsRow(l10n),
                const SizedBox(height: Dimensions.xl),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context, state) {
                    return AuthPrimaryButton(
                      label: l10n.createAccount,
                      isLoading: state.status == AuthStatus.loading,
                      onPressed: () => _submit(l10n),
                    );
                  },
                ),
                const SizedBox(height: Dimensions.lg),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: l10n.alreadyHaveAccount,
                      style: HimTextStyles.linkMuted,
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(l10n.signIn, style: HimTextStyles.linkAction),
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
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Dimensions.avatar,
          height: Dimensions.avatar,
          decoration: BoxDecoration(
            color: HimColors.fieldBackground,
            shape: BoxShape.circle,
            border: Border.all(color: HimColors.primaryLight, width: Dimensions.borderThick),
          ),
          child: const Icon(Icons.person_outline, size: FontSizes.iconLg, color: HimColors.primaryMuted),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: Dimensions.avatarBadge,
            height: Dimensions.avatarBadge,
            decoration: const BoxDecoration(
              color: HimColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt, size: FontSizes.xs, color: HimColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsRow(AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
          child: Container(
            width: Dimensions.checkbox,
            height: Dimensions.checkbox,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: HimColors.fieldBackground,
              borderRadius: BorderRadius.circular(Dimensions.radiusSm),
              border: Border.all(color: HimColors.primary, width: Dimensions.border),
            ),
            child: _acceptedTerms
                ? const Icon(Icons.check, size: FontSizes.xs, color: HimColors.primary)
                : null,
          ),
        ),
        const SizedBox(width: Dimensions.md),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: l10n.termsPrefix,
              style: HimTextStyles.terms,
              children: [
                TextSpan(text: l10n.termsOfService, style: HimTextStyles.termsLink),
                TextSpan(text: l10n.termsAnd, style: HimTextStyles.terms),
                TextSpan(text: l10n.privacyPolicy, style: HimTextStyles.termsLink),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
