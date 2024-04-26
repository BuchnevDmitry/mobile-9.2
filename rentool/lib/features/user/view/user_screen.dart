import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
  });

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
                  style: theme.textTheme.titleLarge,
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  350,
                  55,
                ),
                elevation: 0,
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.primaryColor,
                surfaceTintColor: theme.primaryColor,
              ),
              child: Text(
                'Активные заказы',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  350,
                  55,
                ),
                elevation: 0,
                backgroundColor: const Color(0xffff2f3f3),
                foregroundColor: theme.disabledColor,
                surfaceTintColor: theme.disabledColor,
              ),
              child: Text(
                'Избранное',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'История заказов',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Мои данные',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  350,
                  55,
                ),
                elevation: 0,
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.primaryColor,
                surfaceTintColor: theme.primaryColor,
              ),
              child: Text(
                'Выйти',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
