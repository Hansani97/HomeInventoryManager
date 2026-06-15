import 'package:flutter/material.dart';
import 'package:home_inventory_manager/themes/themes.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.enabled = true,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: HimTextStyles.fieldLabel),
        const SizedBox(height: Dimensions.sm - 1),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          style: HimTextStyles.fieldInput,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: Dimensions.fieldContent,
            prefixIcon: Icon(widget.icon, size: FontSizes.iconSm, color: HimColors.primary),
            suffixIcon: widget.suffixIcon ??
                (widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: FontSizes.iconSm,
                          color: HimColors.primaryLight,
                        ),
                        onPressed: () => setState(() => _obscured = !_obscured),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
