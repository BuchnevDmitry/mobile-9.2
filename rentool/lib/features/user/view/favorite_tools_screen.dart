import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

@RoutePage()
class FavoriteToolsScreen extends StatelessWidget {
  const FavoriteToolsScreen({
    super.key,
  });

  static const String title = 'Избранное';

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        TitleAppBar(title: title),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: ToolsCardGrid(
            tools: [],
          ),
        ),
      ],
    );
  }
}
