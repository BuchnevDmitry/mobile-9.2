import 'dart:async';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/features/metric/metric.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class AdsFeedScreen extends StatefulWidget {
  const AdsFeedScreen({
    super.key,
  });

  @override
  State<AdsFeedScreen> createState() => _AdsFeedScreenState();
}

class _AdsFeedScreenState extends State<AdsFeedScreen> {
  static const String headLine = 'Лента инструментов';
  static const String errorMessage = 'Что-то пошло не так...';
  static const String answerMessage = 'Пожалуйста, повторите попытку позже';
  static const String textButtonMessage = 'Повторить';

  int currentPage = 0;
  bool _isLoading = false;
  late ScrollController _scrollController;
  List<Tool> _allTools = [];
  Set<String> _toolIds = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<YandexMetricsBloc>(context)
        .add(const YandexMetricsOpenScreenEvent(
      screenName: 'Лента объявлений',
    ));
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    BlocProvider.of<AdsFeedBloc>(context)
        .add(AdsFeedLoadEvent(page: currentPage));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoading) _loadMore();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _loadMore() {
    setState(() {
      _isLoading = true;
      currentPage++;
    });
    context.read<AdsFeedBloc>().add(AdsFeedLoadEvent(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () async {
        _refresh(context);
      },
      child: BlocListener<AdsFeedBloc, AdsFeedState>(
        listener: (context, state) {
          if (state is AdsFeedLoadedState ||
              state is AdsFeedLoadingFailureState) {
            setState(() {
              _isLoading = false;
            });

            if (state is AdsFeedLoadedState) {
              _updateAllTools(state.tools.tools);
            }
          }
        },
        child: BlocBuilder<AdsFeedBloc, AdsFeedState>(
          builder: (context, state) {
            if (state is AdsFeedLoadedState) {
              return _buildContent(theme, state);
            }
            if (state is AdsFeedLoadingFailureState) {
              return _buildFailureContent(theme, context);
            }
            return _buildLoadingProgress();
          },
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    setState(() {
      currentPage = 0;
      _isLoading = true;
      _allTools = [];
      _toolIds.clear();
    });
    final completer = Completer();
    BlocProvider.of<AdsFeedBloc>(context)
        .add(AdsFeedLoadEvent(page: currentPage, completer: completer));
    await completer.future;
    setState(() {
      _isLoading = false;
    });
  }

  void _updateAllTools(List<Tool> newTools) {
    for (var tool in newTools) {
      if (!_toolIds.contains(tool.id)) {
        _allTools.add(tool);
        _toolIds.add(tool.id);
      }
    }
  }

  CustomScrollView _buildContent(ThemeData theme, AdsFeedLoadedState state) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        const SearchAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: AdvertisingListCard(advertisings: state.advertisings),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 25),
            child: Text(
              headLine,
              style: theme.textTheme.displaySmall,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tool = _allTools[index];
                final bool isFavorite = state.isFavorite(tool.id);
                return ToolCard(
                  isFavorite: isFavorite,
                  tool: tool,
                  onTap: () => _toggleFavorite(context, tool, state, index),
                );
              },
              childCount: _allTools.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.55,
            ),
          ),
        ),
        if (state.hasMore && _isLoading)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircularProgressIndicator(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _toggleFavorite(BuildContext context, Tool tool,
      AdsFeedLoadedState state, int index) async {
    final completer = Completer();

    if (isAuthorized) {
      final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
      final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
      final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
      final cardProductBloc = BlocProvider.of<CardProductBloc>(context);

      adsFeedBloc.add(AdsFeedToggleFavoriteToolEvent(
        tool: tool,
        completer: completer,
      ));

      await completer.future;
      favoritesBloc.add(FavoritesLoadEvent());
      cardProductBloc.add(CardProductLoadEvent(tool: tool));
      listToolsBloc.add(const ListToolsLoadEvent());
    } else {
      context.router.push(const GuardRoute());
    }
  }

  CustomScrollView _buildLoadingProgress() {
    return const CustomScrollView(
      slivers: [
        SearchAppBar(),
        LoadingCenterProgress(),
      ],
    );
  }

  CustomScrollView _buildFailureContent(ThemeData theme, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SearchAppBar(),
        SliverFillRemaining(
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  errorMessage,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  answerMessage,
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AdsFeedBloc>(context)
                        .add(AdsFeedLoadEvent(page: currentPage));
                  },
                  child: Text(
                    textButtonMessage,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
