import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/shop/widgets/widgets.dart';
import 'package:rentool/router/router.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class OrderPlaceScreen extends StatefulWidget {
  const OrderPlaceScreen({
    super.key,
  });

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  final DateTime _today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        _buildButtonAppBar(),
        const TitleHeader(text: 'Выбор даты'),
        _buildCalendar(),
        const TitleHeader(text: 'Выбор времени'),
        _buildClockPicker(),
        const TitleHeader(text: 'Способ оплаты'),
        _buildChoicePayMethod(theme),
        _buildFinalResult(theme),
        _buildButtonOrder(),
        _buildButtonBack(context),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
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

  SliverToBoxAdapter _buildButtonOrder() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ButtonPrimary(
            onPressed: () async {
              await context.router.push(const ThanksRoute());
            },
            text: 'Заказать',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
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
                '1200 р.',
                style: theme.textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      );

  SliverToBoxAdapter _buildClockPicker() => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BaseRoundContainer(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoDatePicker(
                  use24hFormat: true,
                  initialDateTime: _rangeStart,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (pick) =>
                      setState(() => _rangeStart = pick)),
            ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    'При получении',
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  const Icon(Icons.adjust)
                ],
              ),
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
              lastDay: DateTime.utc(2030, 1, 1),
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
  }
}
