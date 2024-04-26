import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';

class TitleName extends StatelessWidget {
  const TitleName({
    super.key,
    required this.tool,
  });

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          '${tool.category.name}\n${tool.brand.name}\t${tool.model}',
          maxLines: 2,
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}
