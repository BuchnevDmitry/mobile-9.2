import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/widgets/widgets.dart';
import 'package:rentool/features/list_tools/bloc/list_tools_bloc.dart';
import 'package:rentool/api/api.dart';

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
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () async {
        final completer = Completer();
        BlocProvider.of<ListToolsBloc>(context)
            .add(ListToolsLoadEvent(completer: completer));
        completer.future;
      },
      child: BlocBuilder<ListToolsBloc, ListToolsState>(
        builder: (context, state) {
          if (state is ListToolsLoadedState) {
            final tools = state.tools.tools;
            return CustomScrollView(
              slivers: <Widget>[
                // AppBar
                const SearchAppBar(
                  buttonBack: true,
                ),
                // Separator between AppBar and Text
                const SliverToBoxAdapter(child: SizedBox(height: 22)),
                // Text
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      widget.category.name,
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
          if (state is ListToolsLoadingFailureState) {
            return CustomScrollView(
              slivers: <Widget>[
                // AppBar
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
                              style: theme.textTheme.labelSmall,
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
          return const CustomScrollView(
            slivers: <Widget>[
              // AppBar
              SearchAppBar(
                buttonBack: true,
              ),
              LoadingCenterProgress(),
            ],
          );
        },
      ),
    );
  }
}
