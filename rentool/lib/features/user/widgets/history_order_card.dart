import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/router/router.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await context.router.push(const OrderListRoute());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: BaseRoundContainer(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Заказ от 12 марта, 08:471',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '123456789-0001',
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 11,
                    )
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
                      'Способ получения:\nДоставка',
                      style: theme.textTheme.bodySmall,
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Text(
                      'Адресс:\nВоронеж, улица Пушкина, 6, подъезд 1',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
