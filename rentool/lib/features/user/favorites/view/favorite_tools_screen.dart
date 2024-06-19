import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/models/tool.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class FavoriteToolsScreen extends StatefulWidget {
  const FavoriteToolsScreen({
    super.key,
  });

  static const String title = 'Избранное';

  @override
  State<FavoriteToolsScreen> createState() => _FavoriteToolsScreenState();
}

class _FavoriteToolsScreenState extends State<FavoriteToolsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoritesBloc>(context).add(FavoritesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const TitleAppBar(title: FavoriteToolsScreen.title),
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoadedState) {
                final favorites = state.favorites;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: favorites.length,
                      (context, index) => ToolCard(
                          isFavorite: true,
                          tool: favorites[index],
                          onTap: () {
                            _toggleFavorite(context, favorites, index);
                          }),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.55),
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavorite(
      BuildContext context, List<Tool> favorites, int index) async {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    final cardProductBloc = BlocProvider.of<CardProductBloc>(context);

    final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);

    final Completer completer = Completer();
    favoritesBloc.add(
        ToggleFavoriteToolEvent(tool: favorites[index], completer: completer));
    await completer.future;
    adsFeedBloc.add(const AdsFeedLoadEvent());
    listToolsBloc
        .add(ListToolsLoadEvent(category: favorites[index].category.name));
    cardProductBloc.add(CardProductLoadEvent(tool: favorites[index]));
  }
}
