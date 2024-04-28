import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/models/tool.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/bloc/bloc.dart';
import 'package:rentool/features/ads_feed/widgets/widgets.dart';

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

  @override
  void initState() {
    BlocProvider.of<AdsFeedBloc>(context).add(const AdsFeedLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () async {
        final completer = Completer();
        BlocProvider.of<AdsFeedBloc>(context)
            .add(AdsFeedLoadEvent(completer: completer));
        completer.future;
      },
      child: BlocBuilder<AdsFeedBloc, AdsFeedState>(
        builder: (context, state) {
          if (state is AdsFeedLoadedState) {
            final tools = state.tools.tools;
            return buidlLoadedContent(theme, tools);
          }
          if (state is AdsFeedLoadingFailureState) {
            return _buildFailureContent(theme, context);
          }
          return _buildLoadingProgress();
        },
      ),
    );
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

  CustomScrollView buidlLoadedContent(ThemeData theme, List<Tool> tools) {
    return CustomScrollView(
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
        ToolsCardGrid(tools: tools),
      ],
    );
  }
}
