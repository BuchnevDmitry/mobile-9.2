import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/bloc/bloc.dart';
import 'package:rentool/features/ads_feed/widgets/advertising_card.dart';

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
            return CustomScrollView(
              slivers: <Widget>[
                // AppBar
                const SearchAppBar(),
                // Separator between AppBar and AdvertisingCardList
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
                // AdvertisingCardList
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 160,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: advertisingCardResources.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) => AdvertisingCard(
                        imageUrl: advertisingCardResources[index],
                      ),
                    ),
                  ),
                ),
                // Text
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24)
                        .copyWith(top: 25),
                    child: Text(
                      'Лента инструментов',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                // Separator between Text and ToolCardList
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // ToolsCardGrid
                ToolsCardGrid(tools: tools),
              ],
            );
          }
          if (state is AdsFeedLoadingFailureState) {
            return CustomScrollView(
              slivers: <Widget>[
                // AppBar
                const SearchAppBar(),
                SliverFillRemaining(
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
                            BlocProvider.of<AdsFeedBloc>(context)
                                .add(const AdsFeedLoadEvent());
                          },
                          child: Text(
                            'Повторить',
                            style: theme.textTheme.labelSmall,
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
          return const CustomScrollView(
            slivers: [
              // AppBar
              SearchAppBar(),
              LoadingCenterProgress(),
            ],
          );
        },
      ),
    );
  }
}
