import 'package:flutter/material.dart';

class TapString extends StatelessWidget {
  const TapString({
    super.key,
    required this.onTap,
    required this.text,
  });

  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
