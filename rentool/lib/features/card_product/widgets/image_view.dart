import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.tool,
  });

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: 340,
          height: 300,
          child: Image.network(tool.imageUrl),
        ),
      ),
    );
  }
}
