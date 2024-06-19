import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class ThanksScreen extends StatelessWidget {
  const ThanksScreen({
    super.key,
  });

  static const String thanksImage = 'assets/images/rentool-thanks.svg';

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
              thanksImage,
            ),
            const SizedBox(height: 50),
            Text(
              'Спасибо за заказ!',
              style: theme.textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Мы свяжемся с Вами в ближайшее время',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  'для подтверждения заказа',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            ButtonPrimary(
              onPressed: () async {
                final route = context.router;
                await route.pushAndPopUntil(const HomeRoute(),
                    predicate: (_) => false);
              },
              text: 'Вернуться на главную',
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
