import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------

class HimColors {
  static const primary = Color(0xFF1D9E75);
  static const primaryDark = Color(0xFF0F6E56);
  static const primaryDeep = Color(0xFF085041);
  static const primaryLight = Color(0xFF9FE1CB);
  static const primaryMuted = Color(0xFF5DCAA5);
  static const fieldBackground = Color(0xFFE1F5EE);
  static const divider = Color(0xFFC0DD97);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF1A1A1A);
  static const googleRed = Color(0xFFE24B4A);
  static const error = googleRed;
}

// ---------------------------------------------------------------------------
// Font sizes
// ---------------------------------------------------------------------------

class FontSizes {
  static const double xs = 11;
  static const double sm = 12;
  static const double md = 13;
  static const double base = 14;
  static const double lg = 15;
  static const double xl = 17;
  static const double xxl = 20;
  static const double title = 22;
  static const double iconSm = 16;
  static const double iconMd = 22;
  static const double iconLg = 28;
}

// ---------------------------------------------------------------------------
// Dimensions
// ---------------------------------------------------------------------------

class Dimensions {
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 12;
  static const double xl = 14;
  static const double xxl = 16;
  static const double xxxl = 20;
  static const double huge = 24;
  static const double splash = 28;
  static const double header = 36;
  static const double top = 48;

  static const double radiusSm = 5;
  static const double radiusMd = 10;
  static const double radiusLg = 12;
  static const double radiusXl = 14;
  static const double radiusCard = 18;
  static const double radiusSheet = 24;
  static const double radiusSheetLg = 28;

  static const double logoOuter = 62;
  static const double logoInner = 38;
  static const double avatar = 68;
  static const double avatarBadge = 22;
  static const double checkbox = 18;
  static const double strengthBarHeight = 3;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets cardPadding = EdgeInsets.fromLTRB(24, 28, 24, 24);
  static const EdgeInsets registerCardPadding = EdgeInsets.fromLTRB(22, 24, 22, 28);
  static const EdgeInsets registerHeaderPadding = EdgeInsets.fromLTRB(20, 18, 20, 24);
  static const EdgeInsets fieldContent = EdgeInsets.fromLTRB(38, 11, 14, 11);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 13);
  static const EdgeInsets socialButtonPadding = EdgeInsets.symmetric(vertical: 10);

  static const double borderThin = 0.5;
  static const double border = 1.5;
  static const double borderThick = 2;
}

// ---------------------------------------------------------------------------
// Text styles
// ---------------------------------------------------------------------------

class HimTextStyles {
  static const String fontFamily = 'Roboto';

  static const TextStyle splashTitle = TextStyle(
    fontSize: FontSizes.title,
    fontWeight: FontWeight.w500,
    color: HimColors.white,
    letterSpacing: -0.3,
  );

  static const TextStyle splashSubtitle = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryLight,
    height: 1.5,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: FontSizes.xl,
    fontWeight: FontWeight.w500,
    color: HimColors.primaryDeep,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryMuted,
  );

  static const TextStyle registerTitle = TextStyle(
    fontSize: FontSizes.xxl,
    fontWeight: FontWeight.w500,
    color: HimColors.white,
  );

  static const TextStyle registerSubtitle = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryLight,
  );

  static const TextStyle backLink = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryLight,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: FontSizes.xs,
    fontWeight: FontWeight.w500,
    color: HimColors.primaryDark,
    letterSpacing: 0.3,
  );

  static const TextStyle fieldInput = TextStyle(
    fontSize: FontSizes.base,
    color: HimColors.primaryDeep,
  );

  static const TextStyle fieldHint = TextStyle(
    fontSize: FontSizes.base,
    color: HimColors.primaryMuted,
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: FontSizes.lg,
    fontWeight: FontWeight.w500,
    color: HimColors.white,
  );

  static const TextStyle linkAction = TextStyle(
    fontSize: FontSizes.sm,
    color: HimColors.primaryDark,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle linkMuted = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryMuted,
  );

  static const TextStyle divider = TextStyle(
    fontSize: FontSizes.sm,
    color: HimColors.primaryMuted,
  );

  static const TextStyle socialButton = TextStyle(
    fontSize: FontSizes.md,
    color: HimColors.primaryDeep,
  );

  static const TextStyle terms = TextStyle(
    fontSize: FontSizes.sm,
    color: HimColors.primaryMuted,
    height: 1.5,
  );

  static const TextStyle termsLink = TextStyle(
    fontSize: FontSizes.sm,
    color: HimColors.primaryDark,
  );

  static const TextStyle strengthLabel = TextStyle(
    fontSize: FontSizes.xs,
    color: HimColors.primaryDark,
  );

  static const TextStyle homeTitle = TextStyle(
    fontSize: FontSizes.title,
    fontWeight: FontWeight.w500,
    color: HimColors.primaryDeep,
  );

  static const TextStyle homeBody = TextStyle(
    fontSize: FontSizes.lg,
    color: HimColors.primaryDeep,
  );

  static const TextStyle homeEmail = TextStyle(
    fontSize: FontSizes.base,
    color: HimColors.primaryMuted,
  );
}

// ---------------------------------------------------------------------------
// Theme
// ---------------------------------------------------------------------------

class HimTheme {
  AppBarTheme appBarTheme() => const AppBarTheme(
        backgroundColor: HimColors.primary,
        foregroundColor: HimColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: FontSizes.lg,
          fontWeight: FontWeight.w500,
          color: HimColors.white,
        ),
      );

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: HimTextStyles.fontFamily,
      colorScheme: const ColorScheme.light(
        primary: HimColors.primary,
        onPrimary: HimColors.white,
        secondary: HimColors.primaryDark,
        onSecondary: HimColors.white,
        surface: HimColors.white,
        onSurface: HimColors.primaryDeep,
        error: HimColors.error,
        onError: HimColors.white,
      ),
      scaffoldBackgroundColor: HimColors.white,
      appBarTheme: appBarTheme(),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: HimColors.primary,
          foregroundColor: HimColors.white,
          disabledBackgroundColor: HimColors.primary,
          padding: Dimensions.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusXl),
          ),
          elevation: 0,
          textStyle: HimTextStyles.primaryButton,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: HimColors.primaryDeep,
          side: const BorderSide(color: HimColors.primaryLight, width: Dimensions.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          ),
          padding: Dimensions.socialButtonPadding,
          textStyle: HimTextStyles.socialButton,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HimColors.fieldBackground,
        contentPadding: Dimensions.fieldContent,
        hintStyle: HimTextStyles.fieldHint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          borderSide: const BorderSide(color: HimColors.primaryLight, width: Dimensions.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          borderSide: const BorderSide(color: HimColors.primary, width: Dimensions.border),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          borderSide: const BorderSide(color: HimColors.error, width: Dimensions.border),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          borderSide: const BorderSide(color: HimColors.error, width: Dimensions.border),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: HimColors.divider,
        thickness: Dimensions.borderThin,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
