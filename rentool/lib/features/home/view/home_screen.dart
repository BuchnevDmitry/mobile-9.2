import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  static const String homeIcon =
      'assets/icons/home_FILL0_wght400_GRAD0_opsz48.svg';

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
        routes: const [
          AdsFeedWrapperRoute(),
          CatalogWrapperRoute(),
          ShopRoute(),
          UserRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 12,
              selectedItemColor: theme.hintColor.withOpacity(1),
              unselectedItemColor: theme.disabledColor,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) => _openPage(index, tabsRouter),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homeIcon,
                    height: 24,
                    width: 24,
                    colorFilter:
                        ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    homeIcon,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Лента',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search_outlined),
                  label: 'Категории',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall_outlined),
                  label: 'Корзина',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Профиль',
                ),
              ],
            ),
          );
        });
  }
}
