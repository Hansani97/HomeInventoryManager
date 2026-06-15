import 'package:flutter/material.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: FontSizes.iconSm, color: iconColor),
            const SizedBox(width: Dimensions.sm),
            Text(label, style: HimTextStyles.socialButton),
          ],
        ),
      ),
    );
  }
}
