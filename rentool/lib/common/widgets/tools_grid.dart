import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/api/api.dart';

class ToolsCardGrid extends StatelessWidget {
  const ToolsCardGrid({
    super.key,
    required this.tools,
  });

  final List<Tool> tools;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
            childCount: tools.length,
            (context, index) => ToolCard(tool: tools[index])),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.67),
      ),
    );
  }
}
