import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/api/models/models.dart';
import 'package:rentool/router/router.dart';

import 'base_round_container.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    this.isFavorite = false,
    required this.tool,
    required this.onTap,
  });

  final bool isFavorite;
  final Tool tool;
  final VoidCallback onTap;

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
    final nameWithModel = tool.model.split(' ');
    return BaseRoundContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5.0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  iconSize: 24,
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.favorite,
                    color: theme.primaryColor,
                  ),
                  isSelected: isFavorite,
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
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  nameWithModel[0],
                  style: theme.textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${tool.brand.name} ${nameWithModel[1]}',
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
          ),
        ],
      ),
    );
  }
}
