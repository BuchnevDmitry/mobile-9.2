import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/widgets/advertising_card.dart';

@RoutePage()
class AdsFeedScreen extends StatelessWidget {
  const AdsFeedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        // AppBar
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: theme.cardColor,
          surfaceTintColor: Colors.transparent,
          bottom: const PreferredSize(
            preferredSize: Size.fromRadius(10),
            child: SearchButton(),
          ),
        ),
        // Separator between AppBar and AdvertisingCardList
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
        // AdvertisingCardList
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => const AdvertisingCard(
                imageUrl: 'assets/images/',
              ),
            ),
          ),
        ),
        // Text
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 25),
            child: Text(
              'Лента инструментов',
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
            delegate: SliverChildBuilderDelegate((context, index) => ToolCard(
                  imageUrl: 'assets/images/',
                )),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65),
          ),
        )
      ],
    );
  }
}
