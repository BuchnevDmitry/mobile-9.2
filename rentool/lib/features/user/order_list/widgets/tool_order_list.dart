import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/user/user.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required Tools tools,
    required List<RentTool> rentTools,
  })  : _tools = tools,
        _rentTools = rentTools;

  final Tools _tools;
  final List<RentTool> _rentTools;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ToolOrderCard(
              tool: _tools.tools[index],
              count: _rentTools[index].countTool,
            );
          },
          childCount: _tools.tools.length,
        ),
      ),
    );
  }
}
