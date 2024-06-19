import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/map/map.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/shop/widgets/widgets.dart';
import 'package:rentool/router/router.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class OrderPlaceScreen extends StatefulWidget {
  const OrderPlaceScreen({
    super.key,
    required this.sum,
  });

  final int sum;

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  final DateTime _today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  int _finalSum = 0;

  int _currentTimeReceving = TimeReceivings.morning.value;
  final int _currentPayment = Payment.cash.value;

  String _address = '';
  int _method = ReceivingMethods.selfPickup.value;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(OrderLoadEvent());
    BlocProvider.of<MapBloc>(context).add(MapLoadAddressEvent());
    _finalSum = widget.sum;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapLoadedAddressState) {
            _address = state.orderAdress.address;
            _method = state.orderAdress.type;
          }
        },
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderLoadingFailureState) {
              const snackdemo = SnackBar(
                content: Text('Ошибка!'),
                backgroundColor: Colors.red,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(12),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            }
            if (state is OrderEmptyState) {
              final homeBloc = BlocProvider.of<HomeBloc>(context);
              homeBloc.add(HomeBadgeOrderEvent());

              context.router.push(const ThanksRoute());
            }
          },
          child: CustomScrollView(
            slivers: <Widget>[
              _buildButtonAppBar(),
              const TitleHeader(text: 'Выбор даты'),
              _buildCalendar(),
              TitleHeader(
                  text: _method == 1 ? 'Время доставки' : 'Время получения'),
              _buildClockOptions(theme),
              const TitleHeader(text: 'Способ оплаты'),
              _buildChoicePayMethod(theme),
              _buildFinalResult(theme),
              _buildButtonOrder(theme),
              _buildButtonBack(context),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildButtonBack(BuildContext context) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ButtonSecondary(
            onPressed: () async {
              await context.router.maybePop();
            },
            text: 'Вернуться в корзину',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  SliverToBoxAdapter _buildButtonOrder(ThemeData theme) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }
              return ButtonPrimary(
                onPressed: () async {
                  final orderBloc = BlocProvider.of<OrderBloc>(context);
                  final completer = Completer();

                  orderBloc.add(OrderSendRentEvent(
                    startDate: _rangeStart!.toIso8601String(),
                    endDate: _rangeEnd!.toIso8601String(),
                    receivingMethodId: _method,
                    timeReceivingId: _currentTimeReceving,
                    address: _address,
                    completer: completer,
                  ));

                  await completer.future;
                },
                text: 'Заказать',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
      );

  SliverToBoxAdapter _buildFinalResult(ThemeData theme) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                'Итого',
                style: theme.textTheme.headlineLarge,
              ),
              const Spacer(),
              Text(
                '$_finalSum р.',
                style: theme.textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      );

  SliverToBoxAdapter _buildClockOptions(ThemeData theme) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // ignore: use_full_hex_values_for_flutter_colors
                  color: const Color(0xffff2f3f3),
                ),
                child: RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: Colors.black,
                  title: Text(
                    '9:00-12:00',
                    style: theme.textTheme.titleMedium,
                  ),
                  value: TimeReceivings.morning.value,
                  groupValue: _currentTimeReceving,
                  onChanged: (int? value) {
                    setState(() {
                      _currentTimeReceving = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // ignore: use_full_hex_values_for_flutter_colors
                  color: const Color(0xffff2f3f3),
                ),
                child: RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: Colors.black,
                  title: Text(
                    '13:00-18:00',
                    style: theme.textTheme.titleMedium,
                  ),
                  value: TimeReceivings.afternoon.value,
                  groupValue: _currentTimeReceving,
                  onChanged: (int? value) {
                    setState(() {
                      _currentTimeReceving = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  SliverToBoxAdapter _buildChoicePayMethod(ThemeData theme) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // ignore: use_full_hex_values_for_flutter_colors
              color: const Color(0xffff2f3f3),
            ),
            child: RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.black,
              title: Text(
                'При получении',
                style: theme.textTheme.titleMedium,
              ),
              value: Payment.cash.value,
              groupValue: _currentPayment,
              onChanged: (int? value) {
                setState(() {});
              },
            ),
          ),
        ),
      );

  SliverToBoxAdapter _buildCalendar() => SliverToBoxAdapter(
        child: Padding(
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
              focusedDay: _focusedDay,
              firstDay: _today,
              lastDay: _today.add(const Duration(days: 31)),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              onRangeSelected: _onRangeSelected,
            ),
          ),
        ),
      );

  SliverAppBar _buildButtonAppBar() => SliverAppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromRadius(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      onPressed: () async {
                        await context.router.push(const MapDeliveryRoute());
                      },
                      text: 'Доставка',
                      withIcon: true,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ButtonSecondary(
                      onPressed: () async {
                        await context.router.push(const MapPickupRoute());
                      },
                      text: 'Самовывоз',
                      withIcon: true,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );

  void _onRangeSelected(
      DateTime? startDay, DateTime? endDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = startDay;
      _rangeEnd = endDay;
    });

    if (_rangeEnd != null && _rangeStart != null) {
      _calculateFinalSum();
    }
  }

  void _calculateFinalSum() {
    setState(() {
      _finalSum = widget.sum;
      _finalSum *= _daysBetween(_rangeStart!, _rangeEnd!);
    });
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
