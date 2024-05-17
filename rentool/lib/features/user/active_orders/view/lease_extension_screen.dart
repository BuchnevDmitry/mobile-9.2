import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class LeaseExtensionScreen extends StatefulWidget {
  const LeaseExtensionScreen({
    super.key,
  });

  @override
  State<LeaseExtensionScreen> createState() => _LeaseExtensionScreenState();
}

class _LeaseExtensionScreenState extends State<LeaseExtensionScreen> {
  final DateTime _today = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeEnd;

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
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          ButtonPrimary(
            onPressed: () {},
            text: 'Подтвердить',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
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
              '800 р.',
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
            focusedDay: _today,
            firstDay: _today,
            lastDay: _today.add(const Duration(days: 8)),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _today,
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
}
