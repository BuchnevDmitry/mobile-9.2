import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
  });

  static const String textActiveButton = 'Активные заказы';
  static const String textFavoriteButton = 'Избранное';
  static const String textTapHistory = 'История заказов';
  static const String textTapMyData = 'Мои данные';
  static const String textExitButton = 'Выйти';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Васильев Василий',
                  style: theme.textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Text(
                  '+7 999 999-99-99',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 40),
            ButtonPrimary(
              text: textActiveButton,
              onPressed: () async =>
                  await context.router.push(const ActiveOrdersRoute()),
            ),
            const SizedBox(height: 16),
            ButtonSecondary(
                text: textFavoriteButton,
                onPressed: () async =>
                    await context.router.push(const FavoriteToolsRoute())),
            const SizedBox(height: 40),
            Row(children: [
              TapString(
                  text: textTapHistory,
                  onTap: () async =>
                      await context.router.push(const HistoryOrdersRoute()))
            ]),
            const SizedBox(height: 16),
            Row(children: [TapString(text: textTapMyData, onTap: () {})]),
            const Spacer(),
            ButtonPrimary(text: textExitButton, onPressed: () {}),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
