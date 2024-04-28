import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: BaseRoundContainer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
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
                  Text(
                    'Угловая шлифмашинка\nAEG WS13-125XE',
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.25,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Дата доставки:\n12 марта в 10:30',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: <Widget>[
                  Text(
                    'Заказ от 12 марта, 08:47\n123456789-0001',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
