import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentool/api/api.dart';

import 'package:rentool/common/common.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  static const String assetImage = 'assets/logos/rentool-auth.svg';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _controllerLogin;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerFirstName;
  late TextEditingController _controllerLastName;

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController(text: '');
    _controllerPassword = TextEditingController(text: '');
    _controllerPhone = TextEditingController(text: '');
    _controllerEmail = TextEditingController(text: '');
    _controllerFirstName = TextEditingController(text: '');
    _controllerLastName = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          final route = context.router;
          if (state is UserLoadingFailureState) {
            final message = state.message;

            final snackdemo = SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(12),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackdemo);
          }
          if (state is UserRegisterSucsessState) {
            const snackdemo = SnackBar(
              content: Text('Успешно'),
              backgroundColor: Colors.green,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(12),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            route.maybePop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        SvgPicture.asset(
                          RegisterScreen.assetImage,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Регистрация',
                          style: theme.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Создайте свою учетную запись,',
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
                          hintText: 'Телефон',
                          controller: _controllerPhone,
                        ),
                        const SizedBox(height: 16),
                        GreyTextField(
                          hintText: 'Адрес электронной почты',
                          controller: _controllerEmail,
                        ),
                        const SizedBox(height: 16),
                        GreyTextField(
                          hintText: 'Пароль',
                          controller: _controllerPassword,
                        ),
                        const SizedBox(height: 16),
                        GreyTextField(
                          hintText: 'Имя пользователя',
                          controller: _controllerFirstName,
                        ),
                        const SizedBox(height: 16),
                        GreyTextField(
                          hintText: 'Фамилия пользователя',
                          controller: _controllerLastName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              SliverToBoxAdapter(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserRequestState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: theme.primaryColor,
                        ),
                      );
                    }
                    return ButtonPrimary(
                      onPressed: () async {
                        final userBloc = BlocProvider.of<UserBloc>(context);
                        final completer = Completer();

                        final String login = _controllerLogin.text;
                        final String password = _controllerPassword.text;
                        final String firstName = _controllerFirstName.text;
                        final String lastName = _controllerLastName.text;
                        final String phone = _controllerPhone.text;
                        final String email = _controllerEmail.text;

                        final user = User(
                          login: login,
                          password: password,
                          firstName: firstName,
                          lastName: lastName,
                          phone: phone,
                          email: email,
                        );

                        userBloc.add(UserRegisterEvent(
                          user: user,
                          completer: completer,
                        ));

                        await completer.future;
                      },
                      text: 'Создать аккаунт',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
