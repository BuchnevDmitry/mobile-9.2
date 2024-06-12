import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/user/user.dart';

class ActiveOrderListCard extends StatelessWidget {
  const ActiveOrderListCard({
    super.key,
    required List<Rent> rents,
  }) : _rents = rents;

  final List<Rent> _rents;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ActiveOrderCard(rent: _rents[index]);
        },
        childCount: _rents.length,
      ),
    );
  }
}
