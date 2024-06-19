import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/shop/bloc/bloc.dart';
import 'package:rentool/features/shop/bloc/order_bloc.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/repositories/repositories.dart';

class OrderToolCard extends StatelessWidget {
  const OrderToolCard({
    super.key,
    required ToolOrder tool,
  }) : _tool = tool;

  final ToolOrder _tool;

  static const int MAX_COUNT_TOOLS = 3;
  static const int MIN_COUNT_TOOLS = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameWithModel = _tool.model.split(' ');
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
                  child: Image.network(_tool.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${nameWithModel[0]}\n${_tool.brand!.name} ${nameWithModel[1]}',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${_tool.priceDay} р/день',
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
                                onTap: () {
                                  if (_tool.userCount <= MIN_COUNT_TOOLS) {
                                    _removeTool(context);
                                  } else {
                                    _updateRemoveCount(context);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Text('${_tool.userCount}'),
                              GestureDetector(
                                onTap: () {
                                  if (_tool.userCount < MAX_COUNT_TOOLS) {
                                    _updateAddCount(context);
                                  }
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
    int count = _tool.userCount;
    count += 1;
    BlocProvider.of<OrderBloc>(context)
        .add(OrderAddEvent(tool: _tool.toTool(), count: count));
  }

  void _updateRemoveCount(BuildContext context) {
    int count = _tool.userCount;
    count -= 1;
    BlocProvider.of<OrderBloc>(context)
        .add(OrderAddEvent(tool: _tool.toTool(), count: count));
  }

  void _removeTool(BuildContext context) {
    return BlocProvider.of<OrderBloc>(context)
        .add(OrderRemoveToolEvent(tool: _tool));
  }
}
