import 'package:flutter/material.dart';

class LoadingCenterProgress extends StatelessWidget {
  const LoadingCenterProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
