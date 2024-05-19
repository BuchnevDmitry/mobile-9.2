import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/card_product/widgets/widgets.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/list_tools/bloc/bloc.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/features/shop/bloc/bloc.dart';
import 'package:rentool/features/shop/bloc/order_bloc.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/favorites/favorites.dart';

@RoutePage()
class CardProductScreen extends StatefulWidget {
  const CardProductScreen({super.key, required this.tool});

  final Tool tool;

  @override
  State<CardProductScreen> createState() => _CardProductScreenState();
}

class _CardProductScreenState extends State<CardProductScreen> {
  late ValueNotifier<bool> showFullDescription;
  late ValueNotifier<int> counter;

  @override
  void initState() {
    BlocProvider.of<CardProductBloc>(context)
        .add(CardProductLoadEvent(tool: widget.tool));
    showFullDescription = ValueNotifier<bool>(false);
    counter = ValueNotifier<int>(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> lines = widget.tool.description.split(';');
    lines.removeLast();
    return Scaffold(
      body: BlocBuilder<CardProductBloc, CardProductState>(
        builder: (context, state) {
          if (state is CardProductLoadedState) {
            final tool = state.tool;
            final bool isFavorite = state.isFavorite(tool.id);
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromRadius(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              context.router.maybePop();
                            },
                          ),
                        ),
                        const Expanded(
                            child: SearchButton(
                          withBackButton: true,
                        )),
                        IconButton(
                          iconSize: 24,
                          onPressed: () {
                            _toggleFavorite(context, tool);
                          },
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                          ),
                          selectedIcon: Icon(
                            Icons.favorite,
                            color: theme.primaryColor,
                          ),
                          isSelected: isFavorite,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ImageView(tool: widget.tool),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                TitleName(tool: widget.tool),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child:
                        _buildParametersList(lines, showFullDescription, theme),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: theme.primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () => setState(() {
                                        counter.value == 1
                                            ? log('countet >= 1!')
                                            : counter.value--;
                                      }),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 18.5),
                                    child: Icon(Icons.remove),
                                  )),
                              Text('${counter.value}'),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      counter.value >=
                                              (widget.tool.count >= 3
                                                  ? 3
                                                  : widget.tool.count)
                                          ? log('countet >= 3')
                                          : counter.value++;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 18.5),
                                    child: Icon(Icons.add),
                                  )),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 150,
                          child: ButtonPrimary(
                            text: 'В корзину',
                            onPressed: () => _addToolToOrder(context),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            );
          }
          return _buildLoadingProgress();
        },
      ),
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    Tool tool,
  ) async {
    final cardProductBloc = BlocProvider.of<CardProductBloc>(context);
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);
    final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    final completer = Completer();

    cardProductBloc.add(CardProductToggleFavoriteToolEvent(
      tool: tool,
      completer: completer,
    ));

    await completer.future;
    favoritesBloc.add(FavoritesLoadEvent());
    listToolsBloc.add(const ListToolsLoadEvent());
    adsFeedBloc.add(const AdsFeedLoadEvent());
  }

  CustomScrollView _buildLoadingProgress() {
    return const CustomScrollView(
      slivers: [
        SearchAppBar(buttonBack: true),
        LoadingCenterProgress(),
      ],
    );
  }

  void _addToolToOrder(BuildContext context) {
    BlocProvider.of<OrderBloc>(context)
        .add(OrderAddEvent(tool: widget.tool, count: counter.value));
    BlocProvider.of<HomeBloc>(context).add(HomeBadgeOrderEvent());
  }

  Widget _buildParametersList(List<String> lines,
      ValueNotifier<bool> showFullDescription, ThemeData theme) {
    return Column(
      children: [
        for (final line
            in lines.sublist(0, showFullDescription.value ? lines.length : 6))
          _parseDataLine(line, theme),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullDescription.value = !showFullDescription.value;
                });
              },
              child: showFullDescription.value
                  ? Row(
                      children: [
                        Text(
                          'Свернуть параметры',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Icon(
                          Icons.expand_less_outlined,
                          color: Colors.black,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          'Все параметры',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Icon(
                          Icons.expand_more_outlined,
                          color: Colors.black,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _parseDataLine(String line, ThemeData theme) {
    final List<String> parts = line.split('-');
    final List<Widget> rowChildren = [];

    for (final part in parts) {
      final textWidget = Text(
        part,
        style: theme.textTheme.labelMedium,
      );

      if (parts.indexOf(part) < parts.length - 1) {
        rowChildren.add(textWidget);
        rowChildren.add(const Spacer());
      } else {
        rowChildren.add(textWidget);
      }
    }

    return Row(children: rowChildren);
  }
}
