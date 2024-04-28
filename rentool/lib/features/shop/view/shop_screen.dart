import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
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
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: OrderTools(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
              child: ButtonPrimary(
            text: textButton,
            onPressed: () async =>
                await context.router.push(const OrderPlaceRoute()),
          )),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
