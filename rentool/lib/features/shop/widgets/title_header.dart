import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
        child: Text(
          text,
          style: theme.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
