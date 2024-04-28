import 'package:flutter/material.dart';
import 'package:rentool/features/user/widgets/widgets.dart';

class HistoryOrderListCard extends StatelessWidget {
  const HistoryOrderListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const HistoryOrderCard();
        },
        childCount: 4,
      ),
    );
  }
}
