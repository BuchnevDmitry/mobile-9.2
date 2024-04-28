import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.heightSize = 55,
    this.withIcon = false,
  });

  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  final double heightSize;

  final bool withIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return withIcon
        ? _buildButtonWithIcon(theme)
        : _buildButtonWithoutIcon(theme);
  }

  ElevatedButton _buildButtonWithoutIcon(ThemeData theme) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          double.infinity,
          heightSize,
        ),
        elevation: 0,
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: const Color(0xffff2f3f3),
        foregroundColor: theme.disabledColor,
        surfaceTintColor: theme.disabledColor,
      ),
      child: Text(
        text,
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  ElevatedButton _buildButtonWithIcon(ThemeData theme) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          double.infinity,
          heightSize,
        ),
        elevation: 0,
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: const Color(0xffff2f3f3),
        foregroundColor: theme.disabledColor,
        surfaceTintColor: theme.disabledColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: theme.textTheme.titleMedium,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
