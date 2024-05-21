import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/home/bloc/home_bloc.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/shop/widgets/widgets.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class ShopScreen extends StatefulWidget {
  const ShopScreen({
    super.key,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  static const String appBarTitle = 'Корзина';
  static const String textButton = 'К оформлению';

  int sum = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(OrderLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromRadius(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      appBarTitle,
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: IconButton(
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () => _clearOrder(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is! OrderLoadedState) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
                final order = state.order;
                return OrderTools(order: order);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocConsumer<OrderBloc, OrderState>(
              listener: _handleBadgeCount,
              builder: (context, state) {
                if (state is! OrderLoadedState) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
                if (state is OrderLoadingState) {
                  return const LoadingCenterProgress();
                }
                return SliverToBoxAdapter(
                    child: ButtonPrimary(
                        text: textButton,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed: () async {
                          _calcSum(state);
                          await context.router.push(OrderPlaceRoute(sum: sum));
                        }));
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  void _calcSum(OrderLoadedState state) {
    final tools = state.order.tools;
    sum = 0;
    for (var tool in tools) {
      sum += (tool.priceDay * tool.userCount);
    }
  }

  void _handleBadgeCount(BuildContext context, OrderState state) {
    if (state is OrderEmptyState) {
      BlocProvider.of<HomeBloc>(context).add(HomeBadgeOrderEvent());
    } else if (state is OrderLoadedState) {
      BlocProvider.of<HomeBloc>(context).add(HomeBadgeOrderEvent());
    }
  }

  void _clearOrder(BuildContext context) {
    BlocProvider.of<OrderBloc>(context).add(OrderClearEvent());
  }
}
