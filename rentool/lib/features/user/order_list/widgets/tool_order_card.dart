import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';

class ToolOrderCard extends StatelessWidget {
  const ToolOrderCard({
    super.key,
    required Tool tool,
    required int count,
  })  : _tool = tool,
        _count = count;

  final Tool _tool;
  final int _count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameWithModel = _tool.model.split(' ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BaseRoundContainer(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 84,
                height: 84,
                child: ClipRect(
                  child: Image.network(_tool.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${nameWithModel[0]}\n${nameWithModel[1]}',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${_tool.priceDay} р/день',
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: theme.primaryColor,
                          child: Text(_count.toString()),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
