import 'package:flutter/material.dart';
import 'package:home_inventory_manager/generated/l10n/app_localizations.dart';
import 'package:home_inventory_manager/themes/themes.dart';

enum PasswordStrength { none, weak, fair, good, strong }

PasswordStrength evaluatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.none;

  var score = 0;
  if (password.length >= 8) score++;
  if (password.length >= 12) score++;
  if (RegExp(r'[A-Z]').hasMatch(password)) score++;
  if (RegExp(r'[0-9]').hasMatch(password)) score++;
  if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

  if (score <= 1) return PasswordStrength.weak;
  if (score == 2) return PasswordStrength.fair;
  if (score == 3) return PasswordStrength.good;
  return PasswordStrength.strong;
}

extension PasswordStrengthX on PasswordStrength {
  int get filledSegments {
    return switch (this) {
      PasswordStrength.none => 0,
      PasswordStrength.weak => 1,
      PasswordStrength.fair => 2,
      PasswordStrength.good => 3,
      PasswordStrength.strong => 4,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      PasswordStrength.none => '',
      PasswordStrength.weak => l10n.passwordStrengthWeak,
      PasswordStrength.fair => l10n.passwordStrengthFair,
      PasswordStrength.good => l10n.passwordStrengthGood,
      PasswordStrength.strong => l10n.passwordStrengthStrong,
    };
  }

  Color segmentColor(int index) {
    if (index >= filledSegments) return HimColors.divider;
    return switch (this) {
      PasswordStrength.weak => HimColors.googleRed,
      PasswordStrength.fair => HimColors.primaryMuted,
      PasswordStrength.good => HimColors.primary,
      PasswordStrength.strong => HimColors.primary,
      PasswordStrength.none => HimColors.divider,
    };
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.strength});

  final PasswordStrength strength;

  @override
  Widget build(BuildContext context) {
    if (strength == PasswordStrength.none) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimensions.sm),
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                height: Dimensions.strengthBarHeight,
                margin: EdgeInsets.only(right: index < 3 ? 3 : 0),
                decoration: BoxDecoration(
                  color: strength.segmentColor(index),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 3),
        Text(strength.label(l10n), style: HimTextStyles.strengthLabel),
      ],
    );
  }
}
