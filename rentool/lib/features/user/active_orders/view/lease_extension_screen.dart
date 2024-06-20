import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/user.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class LeaseExtensionScreen extends StatefulWidget {
  const LeaseExtensionScreen({
    super.key,
    required Rent rent,
  }) : _rent = rent;

  final Rent _rent;

  @override
  State<LeaseExtensionScreen> createState() => _LeaseExtensionScreenState();
}

class _LeaseExtensionScreenState extends State<LeaseExtensionScreen> {
  late int finalSum;

  late DateTime _startdDay;
  DateTime? _selectedDay;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _startdDay = _getDate(widget._rent.endDate);
    finalSum = 0;
    BlocProvider.of<OrderListBloc>(context)
        .add(OrderListLoadEvent(rent: widget._rent));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromRadius(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    context.router.maybePop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  'Продление аренды',
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
          if (state is OrderListLoadedState) {
            final tools = state.tools;
            finalSum = 0;
            for (var element in tools.tools) {
              finalSum += element.priceDay;
            }

            _calculateFinalSum();
            return _buildContent(theme);
          }
          if (state is OrderListLoadingFailureState) {
            return _buildFailureContent(theme, context);
          }
          return Center(
            child: CircularProgressIndicator(
              color: theme.primaryColor,
            ),
          );
        },
      ),
    );
  }

  Center _buildFailureContent(ThemeData theme, BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            ActiveOrdersScreen.errorMessage,
            style: theme.textTheme.titleSmall,
          ),
          Text(
            ActiveOrdersScreen.answerMessage,
            style: theme.textTheme.labelMedium,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              BlocProvider.of<ActiveOrdersBloc>(context)
                  .add(const ActiveOrdersLoadEvent());
            },
            child: Text(
              ActiveOrdersScreen.textButtonMessage,
              style: theme.textTheme.titleLarge,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Column _buildContent(ThemeData theme) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Выбор даты',
                style: theme.textTheme.headlineLarge,
              ),
            ),
          ],
        ),
        _buildCalendar(),
        const Spacer(),
        _buildFinalResult(theme),
        const SizedBox(height: 16),
        BlocBuilder<ActiveOrdersBloc, ActiveOrdersState>(
          builder: (context, state) {
            if (state is ActiveOrdersLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.primaryColor,
                ),
              );
            }
            return ButtonPrimary(
              onPressed: () async {
                if (_rangeEnd != null) {
                  final rout = context.router;
                  final completer = Completer();
                  final activeOrderBloc =
                      BlocProvider.of<ActiveOrdersBloc>(context);

                  activeOrderBloc.add(ActiveOrdersExtendEvent(
                    id: widget._rent.id,
                    completer: completer,
                    endDate: _rangeEnd!.toIso8601String(),
                  ));
                  await completer.future;
                  rout.maybePop();
                }
              },
              text: 'Подтвердить',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Padding _buildFinalResult(ThemeData theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Text(
              'Итого',
              style: theme.textTheme.headlineLarge,
            ),
            const Spacer(),
            Text(
              '$finalSum р.',
              style: theme.textTheme.headlineLarge,
            ),
          ],
        ),
      );

  Padding _buildCalendar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BaseRoundContainer(
          child: TableCalendar(
            locale: 'ru_Ru',
            rowHeight: 40,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            availableGestures: AvailableGestures.all,
            focusedDay: _startdDay,
            firstDay: _startdDay,
            lastDay: _startdDay.add(const Duration(days: 7)),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _startdDay,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            onRangeSelected: _onRangeSelected,
          ),
        ),
      );

  void _onRangeSelected(
      DateTime? startDay, DateTime? endDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _rangeEnd = focusedDay;
    });
  }

  void _calculateFinalSum() {
    if (_rangeEnd != null) {
      finalSum *= _daysBetween(_startdDay, _rangeEnd!);
    }
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  DateTime _getDate(String raw) {
    return DateTime.parse(raw);
  }
}
