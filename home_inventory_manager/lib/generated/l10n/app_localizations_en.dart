// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Home Inventory Manager';

  @override
  String get homeInventory => 'Home Inventory';

  @override
  String get tagline => 'Track everything you own,\nall in one place.';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInToAccount => 'Sign in to your account';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailHint => 'alex@example.com';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => '••••••••••';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign in';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get createOne => 'Create one';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get createAccountSubtitle => 'Start managing your home inventory';

  @override
  String get firstName => 'First name';

  @override
  String get firstNameHint => 'Alex';

  @override
  String get lastName => 'Last name';

  @override
  String get lastNameHint => 'Kim';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get phoneHint => '0700000000';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get termsPrefix => 'I agree to the ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get termsAnd => ' and ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signOut => 'Sign out';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get signedInDashboardSoon =>
      'You are signed in. Dashboard coming soon.';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get cancel => 'Cancel';

  @override
  String get sendLink => 'Send link';

  @override
  String get fieldRequired => 'Required';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLengthLogin => 'Password must be at least 6 characters';

  @override
  String get passwordMinLengthRegister => 'Use at least 8 characters';

  @override
  String get confirmPasswordRequired => 'Confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get acceptTermsRequired =>
      'Please accept the Terms of Service and Privacy Policy';

  @override
  String get passwordStrengthWeak => 'Weak password';

  @override
  String get passwordStrengthFair => 'Fair password';

  @override
  String get passwordStrengthGood => 'Good password';

  @override
  String get passwordStrengthStrong => 'Strong password';

  @override
  String get userFallback => 'User';
}
