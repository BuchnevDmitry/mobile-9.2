import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

@RoutePage()
class HistoryOrdersScreen extends StatelessWidget {
  const HistoryOrdersScreen({
    super.key,
  });

  static const String title = 'История заказов';

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        TitleAppBar(title: title),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: HistoryOrderListCard(),
        ),
      ],
    );
  }
}
