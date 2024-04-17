import 'package:flutter/material.dart';
import 'base_container.dart';

class ToolCard extends StatelessWidget {
  ToolCard({super.key, required this.imageUrl});

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
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
          BaseContainer(
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: BaseContainer(
                    child: ClipRect(
                      child: Image.asset(imageUrl),
                    ),
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
                  'Шуруповёрт\nMakito',
                  style: theme.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'DF457DWEX9',
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '300 р/час',
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
    );
  }
}
