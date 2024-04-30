import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const ToolOrderCard();
          },
          childCount: 4,
        ),
      ),
    );
  }
}
