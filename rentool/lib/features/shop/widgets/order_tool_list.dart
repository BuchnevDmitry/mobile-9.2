import 'package:flutter/material.dart';
import 'package:rentool/features/shop/widgets/widgets.dart';

class OrderTools extends StatelessWidget {
  const OrderTools({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => const OrderToolCard(),
        childCount: 1,
      ),
    );
  }
}
