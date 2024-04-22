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
      onTap: () {
        context.router.push(ListToolsCategoriesRoute(category: cartegory));
      },
      child: BaseRoundContainer(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cartegory.name,
            style: theme.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
