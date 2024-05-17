import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

@RoutePage()
class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({
    super.key,
  });

  static const String title = 'Активные заказы';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TitleAppBar(title: title),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: ActiveOrderListCard(),
          ),
        ],
      ),
    );
  }
}
