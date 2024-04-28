import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({
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
                  Column(
                    children: [
                      Text(
                        'Заказ от 12 марта, 08:471',
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        '123456789-0001',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
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
                    'Срок аренды:\n12 марта, 10:30 - 14 марта, 10:30',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
              const SizedBox(height: 16),
              ButtonPrimary(
                onPressed: () {},
                text: 'Продлить аренду',
                heightSize: 40,
              ),
              const SizedBox(height: 16),
              ButtonSecondary(
                onPressed: () {},
                text: 'Отказаться от аренды',
                heightSize: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
