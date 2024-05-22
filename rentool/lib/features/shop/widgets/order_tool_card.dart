import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/shop/bloc/bloc.dart';
import 'package:rentool/features/shop/bloc/order_bloc.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/repositories/repositories.dart';

class OrderToolCard extends StatefulWidget {
  const OrderToolCard({
    super.key,
    required this.tool,
  });

  final ToolOrder tool;

  @override
  State<OrderToolCard> createState() => _OrderToolCardState();
}

class _OrderToolCardState extends State<OrderToolCard> {
  late ValueNotifier<int> counter;

  @override
  void initState() {
    counter = ValueNotifier<int>(widget.tool.userCount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameWithModel = widget.tool.model.split(' ');
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
                  child: Image.network(widget.tool.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${nameWithModel[0]}\n${widget.tool.brand!.name} ${nameWithModel[1]}',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.tool.priceDay} р/день',
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
                                    if (counter.value <= 1) {
                                      _removeTool(context);
                                    } else {
                                      _updateRemoveCount(context);
                                    }
                                  },
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Text('${widget.tool.userCount}'),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      if (counter.value < 3) {
                                        _updateAddCount(context);
                                      }
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

  void _updateAddCount(BuildContext context) {
    counter.value++;
    BlocProvider.of<OrderBloc>(context)
        .add(OrderAddEvent(tool: widget.tool.toTool(), count: counter.value));
  }

  void _updateRemoveCount(BuildContext context) {
    counter.value--;
    BlocProvider.of<OrderBloc>(context)
        .add(OrderAddEvent(tool: widget.tool.toTool(), count: counter.value));
  }

  void _removeTool(BuildContext context) {
    return BlocProvider.of<OrderBloc>(context)
        .add(OrderRemoveToolEvent(tool: widget.tool));
  }
}
