import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentool/common/widgets/widgets.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/bloc/list_tools_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/router/router.dart';

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

  String emptyIcon = 'assets/icons/location_searching.svg';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListToolsBloc>(context)
        .add(ListToolsLoadEvent(category: widget.category.name));
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
              if (tools.isEmpty) {
                return _buildEmty(context, theme);
              }
              return _buildContent(theme, tools, state);
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

  CustomScrollView _buildEmty(BuildContext context, ThemeData theme) {
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
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  emptyIcon,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ничего не найдено',
                  style: theme.textTheme.labelMedium,
                ),
                Text(
                  'Попробуйте изменить запрос',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  CustomScrollView _buildContent(
      ThemeData theme, List<Tool> tools, ListToolsLoadedState state) {
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55),
          ),
        ),
      ],
    );
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
        const SearchAppBar(
          buttonBack: true,
        ),
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
                          .add(ListToolsLoadEvent(
                        category: widget.category.name,
                      ));
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

  Future<void> _toggleFavorite(
      BuildContext context, List<Tool> tools, int index) async {
    final completer = Completer();
    if (isAuthorized) {
      final cardProductBloc = BlocProvider.of<CardProductBloc>(context);
      final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
      final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
      final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

      listToolsBloc.add(ListToolsToggleFavoriteToolEvent(
        tool: tools[index],
        completer: completer,
      ));
      await completer.future;
      favoritesBloc.add(FavoritesLoadEvent());
      adsFeedBloc.add(const AdsFeedLoadEvent());
      cardProductBloc.add(CardProductLoadEvent(tool: tools[index]));
    } else {
      context.router.push(const GuardRoute());
    }
  }

  Future<void> _refreshScreen(BuildContext context) async {
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
    final completer = Completer();
    listToolsBloc.add(ListToolsLoadEvent(
      completer: completer,
      category: widget.category.name,
    ));
    await completer.future;
  }
}
