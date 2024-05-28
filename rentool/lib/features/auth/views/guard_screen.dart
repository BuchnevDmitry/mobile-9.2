import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rentool/common/common.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class GuardScreen extends StatelessWidget {
  const GuardScreen({
    super.key,
  });

  static const String assetImage = 'assets/images/rentool-main.svg';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            SvgPicture.asset(
              assetImage,
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Text(
                  'Войдите или зарегиструйтесь,',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  'чтобы пользоваться всеми функциями',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            ButtonPrimary(
              onPressed: () async {
                await context.router.push(const AuthRoute());
              },
              text: 'Войти или зарегистрироваться',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
