import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key, required Rent rent}) : _rent = rent;

  final Rent _rent;
  static const String title = 'Состав заказа';

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderListBloc>(context)
        .add(OrderListLoadEvent(rent: widget._rent));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const TitleAppBar(title: OrderListScreen.title),
          BlocBuilder<OrderListBloc, OrderListState>(
            builder: (context, state) {
              if (state is OrderListLoadedState) {
                return OrderList(
                  tools: state.tools,
                  rentTools: state.rentTools,
                );
              }
              if (state is OrderListLoadingFailureState) {
                return _buildFailureContent(theme, context);
              }
              return const LoadingCenterProgress();
            },
          ),
        ],
      ),
    );
  }

  SliverFillRemaining _buildFailureContent(
      ThemeData theme, BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Center(
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
                  BlocProvider.of<OrderListBloc>(context)
                      .add(OrderListLoadEvent(rent: widget._rent));
                },
                child: Text(
                  ActiveOrdersScreen.textButtonMessage,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
