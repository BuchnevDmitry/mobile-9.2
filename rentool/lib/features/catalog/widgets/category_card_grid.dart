import 'package:flutter/material.dart';
import 'package:rentool/features/catalog/widgets/widgets.dart';
import 'package:rentool/repositories/repositories.dart';

class CategoryCardGrid extends StatelessWidget {
  const CategoryCardGrid({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CategoryCard(cartegory: categories[index]),
          childCount: categories.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.8),
      ),
    );
  }
}
