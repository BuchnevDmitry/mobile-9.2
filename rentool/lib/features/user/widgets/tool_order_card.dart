import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class ToolOrderCard extends StatelessWidget {
  const ToolOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  child: Image.network(
                      'https://cdn.vseinstrumenti.ru/images/goods/stroite…inki-shlifmashinki/11706644/204x184/152946974.jpg'),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Угловая шлифмашинка\nAEG WS13-125XE',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '450 р/день',
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: theme.primaryColor,
                          child: const Text('1'),
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
