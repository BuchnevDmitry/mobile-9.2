import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/api/models/models.dart';
import 'package:rentool/router/router.dart';

import 'base_round_container.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({super.key, required this.tool});

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await context.router.push(CardProductRoute(tool: tool));
      },
      child: _buildCard(theme),
    );
  }

  BaseRoundContainer _buildCard(ThemeData theme) {
    return BaseRoundContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  iconSize: 24,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.favorite,
                    color: theme.primaryColor,
                  ),
                  isSelected: false,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            height: 130,
            child: ClipRect(
              child: Image.network(tool.imageUrl),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                '${tool.category.name}\n${tool.brand.name}',
                style: theme.textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                tool.model,
                style: theme.textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              Text(
                '${tool.priceDay} р/день',
                style: theme.textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
