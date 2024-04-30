import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
      {super.key,
      required this.onPressed,
      required this.text,
      this.heightSize = 55,
      this.withIcon = false,
      required this.style});

  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  final double heightSize;

  final bool withIcon;

  final TextStyle style;

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
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.primaryColor,
        surfaceTintColor: theme.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: style,
          ),
        ],
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
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.primaryColor,
        surfaceTintColor: theme.primaryColor,
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
