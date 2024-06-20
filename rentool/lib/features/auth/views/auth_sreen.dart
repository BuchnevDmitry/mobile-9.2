import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rentool/common/common.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/router/router.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  static const String assetImage = 'assets/logos/rentool-auth.svg';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _controllerLogin;
  late TextEditingController _controllerPassword;

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController(text: '');
    _controllerPassword = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromRadius(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () async {
                    await context.router.maybePop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthorizedState) {
            const snackdemo = SnackBar(
              content: Text('Успешно'),
              backgroundColor: Colors.green,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(12),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            BlocProvider.of<AuthBloc>(context).add(AuthCheckLoginInAppEvent());
            BlocProvider.of<UserBloc>(context).add(const UserLoadEvent());

            final route = context.router;
            route.popUntilRoot();
          }

          if (state is AuthFailedAuthorizedState) {
            const snackdemo = SnackBar(
              content: Text('Неверный логин или пароль'),
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(12),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackdemo);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25),
              Column(
                children: [
                  SvgPicture.asset(
                    AuthScreen.assetImage,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Добро пожаловать!',
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Войдите в свою учетную запись,',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    'чтобы продолжить',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  GreyTextField(
                    hintText: 'Логин',
                    controller: _controllerLogin,
                  ),
                  const SizedBox(height: 16),
                  GreyTextField(
                    hintText: 'Пароль',
                    controller: _controllerPassword,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthRequestState) {
                        return CircularProgressIndicator(
                          color: theme.primaryColor,
                        );
                      }
                      return ButtonPrimary(
                        onPressed: () async {
                          final authBloc = BlocProvider.of<AuthBloc>(context);
                          final completer = Completer();

                          final String username = _controllerLogin.text;
                          final String password = _controllerPassword.text;

                          authBloc.add(AuthAuthorizeEvent(
                            username: username,
                            password: password,
                            completer: completer,
                          ));

                          await completer.future;
                        },
                        text: 'Войти',
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
              const Spacer(),
              ButtonPrimary(
                onPressed: () async {
                  await context.router.push(const RegisterRoute());
                },
                text: 'Зарегистрироваться',
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
      ),
    );
  }
}
