import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class OrderToolCard extends StatefulWidget {
  const OrderToolCard({
    super.key,
  });

  @override
  State<OrderToolCard> createState() => _OrderToolCardState();
}

class _OrderToolCardState extends State<OrderToolCard> {
  late ValueNotifier<int> counter;

  @override
  void initState() {
    counter = ValueNotifier<int>(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BaseRoundContainer(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                  Row(
                    children: [
                      Text(
                        '450 р/день',
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          width: 110,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: theme.primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => setState(
                                  () {
                                    counter.value == 1
                                        ? debugPrint('countet >= 1!')
                                        : counter.value--;
                                  },
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Text('${counter.value}'),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      counter.value == 10
                                          ? debugPrint('countet >= ${10}')
                                          : counter.value++;
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
