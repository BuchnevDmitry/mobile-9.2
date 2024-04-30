import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

@RoutePage()
class OrderListScreen extends StatelessWidget {
  const OrderListScreen({
    super.key,
  });

  static const String title = 'Состав заказа';

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        TitleAppBar(title: title),
        OrderList(),
      ],
    );
  }
}
