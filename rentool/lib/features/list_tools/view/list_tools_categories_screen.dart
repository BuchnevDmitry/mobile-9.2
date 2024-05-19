import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/widgets/widgets.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/bloc/list_tools_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class ListToolsCategoriesScreen extends StatefulWidget {
  const ListToolsCategoriesScreen({super.key, required this.category});

  final Category category;

  @override
  State<ListToolsCategoriesScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ListToolsCategoriesScreenState();
}

class _ListToolsCategoriesScreenState extends State<ListToolsCategoriesScreen> {
  _ListToolsCategoriesScreenState();

  @override
  void initState() {
    BlocProvider.of<ListToolsBloc>(context).add(const ListToolsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: RefreshIndicator(
        color: theme.primaryColor,
        onRefresh: () async {
          _refreshScreen(context);
        },
        child: BlocBuilder<ListToolsBloc, ListToolsState>(
          builder: (context, state) {
            if (state is ListToolsLoadedState) {
              final tools = state.tools.tools;
              return CustomScrollView(
                slivers: <Widget>[
                  const SearchAppBar(
                    buttonBack: true,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 22)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.category.name,
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: tools.length,
                        (context, index) => ToolCard(
                            isFavorite: state.isFavorite(tools[index].id),
                            tool: tools[index],
                            onTap: () {
                              _toggleFavorite(context, tools, index);
                            }),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.55),
                    ),
                  ),
                ],
              );
            }
            if (state is ListToolsLoadingFailureState) {
              return _buildFailureContent(theme, context);
            }
            return __buildLoadingProgress();
          },
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(
      BuildContext context, List<Tool> tools, int index) async {
    final cardProductBloc = BlocProvider.of<CardProductBloc>(context);
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
    final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    final completer = Completer();

    listToolsBloc.add(ListToolsToggleFavoriteToolEvent(
      tool: tools[index],
      completer: completer,
    ));
    await completer.future;
    favoritesBloc.add(FavoritesLoadEvent());
    adsFeedBloc.add(const AdsFeedLoadEvent());
    cardProductBloc.add(CardProductLoadEvent(tool: tools[index]));
  }

  Future<void> _refreshScreen(BuildContext context) async {
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
    final completer = Completer();
    listToolsBloc.add(ListToolsLoadEvent(completer: completer));
    await completer.future;
  }

  CustomScrollView __buildLoadingProgress() {
    return const CustomScrollView(
      slivers: <Widget>[
        SearchAppBar(
          buttonBack: true,
        ),
        LoadingCenterProgress(),
      ],
    );
  }

  CustomScrollView _buildFailureContent(ThemeData theme, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SearchAppBar(),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'Что-то пошло не так...',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    'Пожалуйста, повторите попытку позже',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ListToolsBloc>(context)
                          .add(const ListToolsLoadEvent());
                    },
                    child: Text(
                      'Повторить',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
