import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/user/user.dart';

class HistoryOrderListCard extends StatelessWidget {
  const HistoryOrderListCard({
    super.key,
    required List<Rent> rents,
  }) : _rents = rents;

  final List<Rent> _rents;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return HistoryOrderCard(rent: _rents[index]);
        },
        childCount: _rents.length,
      ),
    );
  }
}
