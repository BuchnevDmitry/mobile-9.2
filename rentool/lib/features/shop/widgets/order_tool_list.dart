import 'package:flutter/material.dart';
import 'package:rentool/features/shop/widgets/widgets.dart';
import 'package:rentool/repositories/repositories.dart';

class OrderTools extends StatelessWidget {
  const OrderTools({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => OrderToolCard(tool: order.tools[index]),
        childCount: order.tools.length,
      ),
    );
  }
}
