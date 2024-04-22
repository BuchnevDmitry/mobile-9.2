import 'package:flutter/material.dart';
import 'package:rentool/api/models/models.dart';

import 'base_round_container.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({super.key, required this.tool});

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: BaseRoundContainer(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 4,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
        child: Column(
          children: <Widget>[
            BaseRoundContainer(
              child: Stack(
                children: <Widget>[
                  BaseRoundContainer(
                    width: 160,
                    height: 170,
                    child: ClipRect(
                      child: Image.network(tool.imageUrl),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text(
                    '${tool.category.name}\n${tool.brand.name}',
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    tool.model,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${tool.priceHour} р/час',
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
