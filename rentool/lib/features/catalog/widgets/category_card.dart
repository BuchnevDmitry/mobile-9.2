import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/api/models/models.dart';
import 'package:rentool/router/router.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.cartegory});

  final Category cartegory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await context.router
            .push(ListToolsCategoriesRoute(category: cartegory));
      },
      child: _buildCard(theme),
    );
  }

  BaseRoundContainer _buildCard(ThemeData theme) {
    return BaseRoundContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          cartegory.name,
          style: theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
