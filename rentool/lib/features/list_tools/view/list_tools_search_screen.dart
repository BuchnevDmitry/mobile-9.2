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
class ListToolsSearchScreen extends StatefulWidget {
  const ListToolsSearchScreen({super.key, required this.searchText});

  final String searchText;

  @override
  State<ListToolsSearchScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ListToolsSearchScreenState();
}

class _ListToolsSearchScreenState extends State<ListToolsSearchScreen> {
  final List<String> _sortMethods = ['По возрастанию', 'По убыванию'];

  String currentTextSearch = '';
  String? _currentSortMethod;

  String emptyIcon = 'assets/icons/location_searching.svg';

  @override
  void initState() {
    super.initState();
    _currentSortMethod = _sortMethods[0];
    currentTextSearch = widget.searchText;
    BlocProvider.of<ListToolsBloc>(context)
        .add(ListToolsLoadEvent(category: widget.searchText));
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
              } else {
                return _buildContent(context, theme, tools, state);
              }
            }
            if (state is ListToolsLoadingFailureState) {
              return _buildFailureContent(theme, context);
            }
            return __buildLoadingProgress(context, theme);
          },
        ),
      ),
    );
  }

  CustomScrollView _buildEmty(BuildContext context, ThemeData theme) {
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: Color(0xffff3f4f5),
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: SizedBox(
                      height: 24,
                      child: TextField(
                        onSubmitted: _onLoad,
                        style: theme.textTheme.bodyMedium,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const InkWell(
                              child: Icon(Icons.search),
                            ),
                            hintText: currentTextSearch,
                            hintStyle: theme.textTheme.labelSmall),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: _buildBottomSheet);
                  },
                  icon: const Icon(Icons.tune_outlined),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 22)),
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

  CustomScrollView _buildContent(BuildContext context, ThemeData theme,
      List<Tool> tools, ListToolsLoadedState state) {
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: Color(0xffff3f4f5),
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: SizedBox(
                      height: 24,
                      child: TextField(
                        onSubmitted: _onLoad,
                        style: theme.textTheme.bodyMedium,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const InkWell(
                              child: Icon(Icons.search),
                            ),
                            hintText: currentTextSearch,
                            hintStyle: theme.textTheme.labelSmall),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: _buildBottomSheet);
                    },
                    icon: const Icon(Icons.tune_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 22)),
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

  CustomScrollView __buildLoadingProgress(
      BuildContext context, ThemeData theme) {
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: Color(0xffff3f4f5),
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                    ),
                    child: SizedBox(
                      height: 24,
                      child: TextField(
                        onSubmitted: _onLoad,
                        style: theme.textTheme.bodyMedium,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const InkWell(
                              child: Icon(Icons.search),
                            ),
                            hintText: currentTextSearch,
                            hintStyle: theme.textTheme.labelSmall),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: _buildBottomSheet);
                    },
                    icon: const Icon(Icons.tune_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
        const LoadingCenterProgress(),
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
                        category: currentTextSearch,
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

  Future<void> _onLoad(String searchText) async {
    setState(() {
      currentTextSearch = searchText;
    });
    final listToolsBloc = BlocProvider.of<ListToolsBloc>(context);

    final completer = Completer();
    listToolsBloc.add(ListToolsLoadEvent(
      completer: completer,
      category: currentTextSearch,
      sortMethod: _currentSortMethod!,
    ));
    await completer.future;
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
      category: currentTextSearch,
      sortMethod: _currentSortMethod!,
    ));
    await completer.future;
  }

  Widget _buildBottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  Text(
                    'Настройки поиска',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    'Сортировка по цене',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xfffaaaaaa),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _sortMethods.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    activeColor: Colors.black,
                    title: Text(
                      _sortMethods[index],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: _sortMethods[index],
                    groupValue: _currentSortMethod,
                    onChanged: (String? value) {
                      setState(() {
                        _currentSortMethod = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              ButtonPrimary(
                onPressed: () {
                  context.router.maybePop();
                  BlocProvider.of<ListToolsBloc>(context)
                      .add(ListToolsLoadEvent(
                    category: currentTextSearch,
                    sortMethod: _currentSortMethod!,
                  ));
                },
                text: 'Применить',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
