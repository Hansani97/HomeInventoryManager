// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Administrador de Inventario del Hogar';

  @override
  String get homeInventory => 'Inventario del Hogar';

  @override
  String get tagline => 'Controla todo lo que posees,\ntodo en un solo lugar.';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signInToAccount => 'Inicia sesión en tu cuenta';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get emailHint => 'alex@ejemplo.com';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordHint => '••••••••••';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get orContinueWith => 'o continúa con';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get noAccount => '¿No tienes una cuenta? ';

  @override
  String get createOne => 'Crear una';

  @override
  String get backToSignIn => 'Volver a iniciar sesión';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get createAccountSubtitle =>
      'Comienza a gestionar el inventario de tu hogar';

  @override
  String get firstName => 'Nombre';

  @override
  String get firstNameHint => 'Alex';

  @override
  String get lastName => 'Apellido';

  @override
  String get lastNameHint => 'Kim';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get phoneHint => '0700000000';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get termsPrefix => 'Acepto los ';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get termsAnd => ' y la ';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String welcomeUser(String name) {
    return '¡Bienvenido, $name!';
  }

  @override
  String get signedInDashboardSoon =>
      'Has iniciado sesión. El panel estará disponible pronto.';

  @override
  String get forgotPasswordTitle => 'Olvidaste tu contraseña';

  @override
  String get cancel => 'Cancelar';

  @override
  String get sendLink => 'Enviar enlace';

  @override
  String get fieldRequired => 'Obligatorio';

  @override
  String get emailRequired => 'El correo es obligatorio';

  @override
  String get emailInvalid => 'Ingresa un correo válido';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordMinLengthLogin =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordMinLengthRegister => 'Usa al menos 8 caracteres';

  @override
  String get confirmPasswordRequired => 'Confirma tu contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get acceptTermsRequired =>
      'Acepta los Términos de Servicio y la Política de Privacidad';

  @override
  String get passwordStrengthWeak => 'Contraseña débil';

  @override
  String get passwordStrengthFair => 'Contraseña regular';

  @override
  String get passwordStrengthGood => 'Buena contraseña';

  @override
  String get passwordStrengthStrong => 'Contraseña segura';

  @override
  String get userFallback => 'Usuario';
}
