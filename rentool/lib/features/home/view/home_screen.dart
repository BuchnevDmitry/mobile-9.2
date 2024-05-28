import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/auth/bloc/auth_bloc.dart';
import 'package:rentool/features/home/bloc/home_bloc.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const String homeIcon =
      'assets/icons/home_FILL0_wght400_GRAD0_opsz48.svg';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeBadgeOrderEvent());
    BlocProvider.of<AuthBloc>(context).add(AuthCheckLoginInAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
        lazyLoad: false,
        duration: const Duration(milliseconds: 0),
        routes: const [
          AdsFeedWrapperRoute(),
          CatalogWrapperRoute(),
          ShopWrapperRoute(),
          UserWrapperRoute(),
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
                    HomeScreen.homeIcon,
                    height: 24,
                    width: 24,
                    colorFilter:
                        ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    HomeScreen.homeIcon,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Лента',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search_outlined),
                  label: 'Категории',
                ),
                BottomNavigationBarItem(
                  icon: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeOrderLoadedState) {
                        final int count = state.count;
                        return Badge(
                          label: Text('$count'),
                          largeSize: 14,
                          textStyle: const TextStyle(fontSize: 12),
                          backgroundColor: const Color(0xfff7c815),
                          child: const Icon(Icons.local_mall_outlined),
                        );
                      }
                      return const Icon(Icons.local_mall_outlined);
                    },
                  ),
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

  void _openPage(int index, TabsRouter tabsRouter) {
    if (index == 3) {
      if (isAuthorized) {
        tabsRouter.setActiveIndex(index);
      } else {
        context.router.push(const GuardRoute());
      }
    } else {
      tabsRouter.setActiveIndex(index);
    }
  }
}
