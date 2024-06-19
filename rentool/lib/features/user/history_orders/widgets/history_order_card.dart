import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/router/router.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard({
    super.key,
    required Rent rent,
  }) : _rent = rent;

  final Rent _rent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await context.router.push(OrderListRoute(rent: _rent));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: BaseRoundContainer(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                _buildCreatedAt(theme),
                _builId(theme),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.25,
                ),
                _buildStartDate(theme),
                const SizedBox(height: 6),
                _buildRecivingMethod(theme),
                const SizedBox(height: 6),
                _buildAddress(theme),
                const SizedBox(height: 6),
                _buildStartEnd(theme),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildStartEnd(ThemeData theme) {
    return Row(
      children: <Widget>[
        Text(
          'Срок аренды:\n${_getDate(_rent.startDate, true)} - ${_getDate(_rent.endDate, true)}',
          style: theme.textTheme.bodySmall,
        )
      ],
    );
  }

  Row _buildAddress(ThemeData theme) {
    return Row(
      children: <Widget>[
        Text(
          'Адресс:\n${_rent.address}',
          style: theme.textTheme.bodySmall,
        )
      ],
    );
  }

  Row _buildRecivingMethod(ThemeData theme) {
    return Row(
      children: <Widget>[
        Text(
          'Способ получения:\n${_rent.receivingMethod.description}',
          style: theme.textTheme.bodySmall,
        )
      ],
    );
  }

  Row _buildStartDate(ThemeData theme) {
    return Row(
      children: <Widget>[
        Text(
          'Дата доставки:\n${_getDate(_rent.startDate, true)}',
          style: theme.textTheme.bodySmall,
        )
      ],
    );
  }

  Row _builId(ThemeData theme) {
    return Row(
      children: [
        Text(
          _rent.id,
          style: theme.textTheme.bodySmall,
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 11,
        )
      ],
    );
  }

  Row _buildCreatedAt(ThemeData theme) {
    return Row(
      children: [
        Text(
          'Заказ от ${_getDate(_rent.createdAt, false)}',
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }

  String _getDate(String raw, bool isStart) {
    if (isStart) {
      final parseDate = DateTime.parse(raw);
      final dayDate = DateFormat.MMMMd('RU').format(parseDate);
      return '$dayDate, ${_rent.timeReceiving.description}';
    }
    final parseDate = DateTime.parse(raw);
    final dayDate = DateFormat.MMMMd('RU').format(parseDate);
    return dayDate;
  }
}
