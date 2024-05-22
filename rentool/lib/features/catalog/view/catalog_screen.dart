import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/models/category.dart';
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
  static const String headLine = 'Категории';
  static const String errorMessage = 'Что-то пошло не так...';
  static const String answerMessage = 'Пожалуйста, повторите попытку позже';
  static const String textButtonMessage = 'Повторить';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CatalogBloc>(context).add(const CatalogLoadEvent());
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
            return _buildLoadedContent(theme, categories);
          }
          if (state is CatalogLoadingFailureState) {
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
                      BlocProvider.of<CatalogBloc>(context)
                          .add(const CatalogLoadEvent());
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
        ),
      ],
    );
  }

  CustomScrollView _buildLoadedContent(
      ThemeData theme, List<Category> categories) {
    return CustomScrollView(
      slivers: <Widget>[
        const SearchAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 22)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              headLine,
              style: theme.textTheme.displaySmall,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        CategoryCardGrid(categories: categories),
      ],
    );
  }
}
