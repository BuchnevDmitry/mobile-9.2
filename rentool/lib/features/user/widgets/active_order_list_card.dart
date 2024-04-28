import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

class ActiveOrderListCard extends StatelessWidget {
  const ActiveOrderListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ActiveOrderCard();
        },
        childCount: 4,
      ),
    );
  }
}
