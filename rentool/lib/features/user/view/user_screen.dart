import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/api/models/user.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/list_tools/list_tools.dart';

import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  static const String textActiveButton = 'Активные заказы';
  static const String textFavoriteButton = 'Избранное';
  static const String textTapHistory = 'История заказов';
  static const String textExitButton = 'Выйти';
  static const String textChangePasswordButton = 'Изменить пароль';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _controllerNewPassword;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(const UserLoadEvent());
    BlocProvider.of<FavoritesBloc>(context).add(FavoritesLoadEvent());

    _controllerNewPassword = TextEditingController(text: '');
  }

  void _refreshToken(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    authBloc.add(AuthRefreshEvent());
    userBloc.add(const UserLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadingFailureState) {
          _refreshToken(context);
        }
        if (state is UserLogoutState) {
          final authBloc = BlocProvider.of<AuthBloc>(context);

          authBloc.add(AuthLogoutEvent());
          context.router
              .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            final user = state.user;
            return _buildContent(user, theme, context);
          }
          return _buildLoading(theme);
        },
      ),
    );
  }

  Scaffold _buildContent(User user, ThemeData theme, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: theme.textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Text(
                  '${user.phone}',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 40),
            ButtonPrimary(
              text: UserScreen.textActiveButton,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              onPressed: () async =>
                  await context.router.push(const ActiveOrdersRoute()),
            ),
            const SizedBox(height: 16),
            ButtonSecondary(
                text: UserScreen.textFavoriteButton,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () async =>
                    await context.router.push(const FavoriteToolsRoute())),
            const SizedBox(height: 40),
            Row(children: [
              TapString(
                  text: UserScreen.textTapHistory,
                  onTap: () async =>
                      await context.router.push(const HistoryOrdersRoute()))
            ]),
            const SizedBox(height: 16),
            const Spacer(),
            ButtonSecondary(
              text: UserScreen.textChangePasswordButton,
              onPressed: () async {
                showModalBottomSheet(
                    context: context, builder: _buildBottomSheet);
              },
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoadedState) {
                  final tools = state.favorites;
                  return ButtonPrimary(
                    text: UserScreen.textExitButton,
                    onPressed: () async {
                      final authBloc = BlocProvider.of<AuthBloc>(context);
                      final orderBloc = BlocProvider.of<OrderBloc>(context);
                      final favoritesBloc =
                          BlocProvider.of<FavoritesBloc>(context);
                      final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);
                      final cardProductBloc =
                          BlocProvider.of<CardProductBloc>(context);
                      final listToolsBloc =
                          BlocProvider.of<ListToolsBloc>(context);

                      favoritesBloc.add(FavoritesClearEvent());
                      orderBloc.add(OrderClearEvent());
                      adsFeedBloc.add(const AdsFeedLoadEvent());

                      for (var tool in tools) {
                        listToolsBloc.add(
                            ListToolsLoadEvent(category: tool.category.name));
                        cardProductBloc.add(CardProductLoadEvent(tool: tool));
                      }

                      authBloc.add(AuthLogoutEvent());

                      await context.router.pushAndPopUntil(const HomeRoute(),
                          predicate: (_) => false);
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return ButtonPrimary(
                  text: UserScreen.textExitButton,
                  onPressed: () async {
                    final authBloc = BlocProvider.of<AuthBloc>(context);
                    final orderBloc = BlocProvider.of<OrderBloc>(context);
                    final favoritesBloc =
                        BlocProvider.of<FavoritesBloc>(context);
                    final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);

                    favoritesBloc.add(FavoritesClearEvent());
                    orderBloc.add(OrderClearEvent());
                    adsFeedBloc.add(const AdsFeedLoadEvent());

                    authBloc.add(AuthLogoutEvent());

                    await context.router.pushAndPopUntil(const HomeRoute(),
                        predicate: (_) => false);
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Scaffold _buildLoading(ThemeData theme) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: theme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text(
                      'Изменение пароля',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text(
                      'Введите новый пароль',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GreyTextField(
                  hintText: 'Новый пароль',
                  controller: _controllerNewPassword,
                ),
                const SizedBox(height: 16),
                ButtonPrimary(
                  onPressed: () async {
                    if (_controllerNewPassword.text.isNotEmpty) {
                      final Completer completer = Completer();
                      final rout = context.router;

                      rout.maybePop();

                      rout.pushAndPopUntil(const HomeRoute(),
                          predicate: (_) => false);

                      final userBloc = BlocProvider.of<UserBloc>(context);
                      final orderBloc = BlocProvider.of<OrderBloc>(context);

                      final favoritesBloc =
                          BlocProvider.of<FavoritesBloc>(context);
                      final adsFeedBloc = BlocProvider.of<AdsFeedBloc>(context);

                      favoritesBloc.add(FavoritesClearEvent());
                      orderBloc.add(OrderClearEvent());

                      adsFeedBloc.add(const AdsFeedLoadEvent());

                      userBloc.add(UserChangePasswordEvent(
                        completer: completer,
                        password: _controllerNewPassword.text,
                      ));

                      await completer.future;
                    } else {
                      const snackdemo = SnackBar(
                        content: Text('Поле не должно быть пустым!'),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(12),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    }
                  },
                  text: 'Подтвердить',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
