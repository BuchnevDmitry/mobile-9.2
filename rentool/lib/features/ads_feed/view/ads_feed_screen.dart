import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/models/tool.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/bloc/ads_feed_bloc.dart';
import 'package:rentool/features/ads_feed/bloc/bloc.dart';
import 'package:rentool/features/ads_feed/widgets/widgets.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/card_product/bloc/bloc.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
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
  static const List<String> advertisingCardResources = [
    'assets/tests/ad_first.jpeg',
    'assets/tests/ad_second.jpeg',
    'assets/tests/ad_third.jpeg',
  ];

  static const String headLine = 'Лента инструментов';
  static const String errorMessage = 'Что-то пошло не так...';
  static const String answerMessage = 'Пожалуйста, повторите попытку позже';
  static const String textButtonMessage = 'Повторить';

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdsFeedBloc>(context).add(const AdsFeedLoadEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        listener: (context, state) {},
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
    final completer = Completer();
    BlocProvider.of<AdsFeedBloc>(context)
        .add(AdsFeedLoadEvent(completer: completer));
    completer.future;
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AdsFeedBloc>().add(const AdsFeedLoadEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  CustomScrollView _buildContent(ThemeData theme, AdsFeedLoadedState state) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        const SearchAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: AdvertisingListCard(
                advertisingCardResources: advertisingCardResources),
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
                childCount: state.tools.tools.length, (context, index) {
              final tool = state.tools.tools[index];
              final bool isFavorite = state.isFavorite(tool.id);
              return ToolCard(
                isFavorite: isFavorite,
                tool: tool,
                onTap: () => _toggleFavorite(context, tool, state, index),
              );
            }),
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
                        .add(const AdsFeedLoadEvent());
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
