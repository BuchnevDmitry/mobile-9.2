import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/catalog/widgets/card_category.dart';
import 'package:rentool/localization/localization.dart';

@RoutePage()
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        // AppBar
        const SliverAppBar(
          pinned: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromRadius(10),
            child: SearchButton(),
          ),
        ),
        // Separator between AppBar and AdvertisingCardList
        const SliverToBoxAdapter(child: SizedBox(height: 22)),
        // Text
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Категории',
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
        // Separator between Text and ToolCardList
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        // ToolCardList
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  CardCategory(cartegory: AppText.categories[index]),
              childCount: AppText.categories.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8),
          ),
        )
      ],
    );
  }
}
