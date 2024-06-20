import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/active_orders/active_orders.dart';
import 'package:rentool/router/router.dart';

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({
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
                _buildId(theme),
                _buildStatus(_rent.status),
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
                _buildLeaseButton(context, _rent),
                SizedBox(
                    height: _rent.status.id == Statuses.received.value ? 8 : 0),
                _buildCancelButton(context, _rent.status),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, Status status) {
    String text = status.id == Statuses.received.value
        ? 'Завершить аренду'
        : 'Отменить аренду';
    final rout = context.router;
    final completer = Completer();

    return status.id != Statuses.awaitingReturn.value &&
            status.id != Statuses.extended.value
        ? ButtonSecondary(
            onPressed: () {
              _buildConfirmBottomSheet(context, text, status, completer, rout);
            },
            text: text,
            heightSize: 40,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          )
        : const SizedBox();
  }

  Future<dynamic> _buildConfirmBottomSheet(BuildContext context, String text,
      Status status, Completer<dynamic> completer, StackRouter rout) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ConfirmBottomSheet(
        buttonText: 'Подтвердить',
        mainText: '$text?',
        questionText: 'Вы действительно хотите ${text.toLowerCase()}?',
        onPressed: () async {
          if (status.id == Statuses.received.value) {
            final activeOrderBloc = BlocProvider.of<ActiveOrdersBloc>(context);

            activeOrderBloc.add(ActiveOrdersReturnEvent(
              id: _rent.id,
              completer: completer,
            ));
            await completer.future;
            rout.maybePop();
          } else {
            final activeOrderBloc = BlocProvider.of<ActiveOrdersBloc>(context);

            activeOrderBloc.add(ActiveOrdersCancelEvent(
              id: _rent.id,
              completer: completer,
            ));
            await completer.future;
            rout.maybePop();
          }
        },
      ),
    );
  }

  Widget _buildLeaseButton(BuildContext context, Rent rent) {
    return rent.status.id == Statuses.received.value
        ? ButtonPrimary(
            onPressed: () async {
              await context.router.push(LeaseExtensionRoute(rent: rent));
            },
            text: 'Продлить заказ',
            heightSize: 40,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          )
        : const SizedBox();
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
      children: [
        Expanded(
          child: Text(
            'Адресс:\n${_rent.address}',
            style: theme.textTheme.bodySmall,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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

  Row _buildStatus(Status status) {
    Color color;

    switch (status.id) {
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = const Color(0xfffab815);
        break;
      case 3:
        color = Colors.green;
        break;
      case 6:
        color = const Color(0xfffab815);
        break;
      case 7:
        color = Colors.green;
        break;
      default:
        color = Colors.black;
    }

    return Row(
      children: [
        Text(
          status.description,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Row _buildId(ThemeData theme) {
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
