import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentool/api/api.dart';

class TitleName extends StatelessWidget {
  const TitleName({
    super.key,
    required this.tool,
  });

  final Tool tool;

  static const String moneyIcon = 'assets/icons/database.svg';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  tool.category.name,
                  style: theme.textTheme.headlineLarge,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${tool.brand.name}\t${tool.model}',
                  style: theme.textTheme.headlineLarge,
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  moneyIcon,
                  width: 18,
                  height: 18,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  '${tool.priceDay} р/день',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
