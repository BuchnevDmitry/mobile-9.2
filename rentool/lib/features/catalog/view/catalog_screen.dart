import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/catalog/bloc/bloc.dart';
import 'package:rentool/features/catalog/widgets/widgets.dart';

@RoutePage()
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    BlocProvider.of<CatalogBloc>(context).add(const CatalogLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () async {
        final completer = Completer();
        BlocProvider.of<CatalogBloc>(context)
            .add(CatalogLoadEvent(completer: completer));
        completer.future;
      },
      child: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoadedState) {
            final categories = state.categories.categories;
            return CustomScrollView(
              slivers: <Widget>[
                // AppBar
                const SearchAppBar(),
                const SliverToBoxAdapter(child: SizedBox(height: 22)),
                // Text
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Категории',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                CategoryCardGrid(categories: categories),
              ],
            );
          }
          if (state is CatalogLoadingFailureState) {
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
                              BlocProvider.of<CatalogBloc>(context)
                                  .add(const CatalogLoadEvent());
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
