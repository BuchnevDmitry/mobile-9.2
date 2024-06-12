import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({
    super.key,
  });

  static const String title = 'Активные заказы';
  static const String errorMessage = 'Что-то пошло не так...';
  static const String answerMessage = 'Пожалуйста, повторите попытку позже';
  static const String textButtonMessage = 'Повторить';

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ActiveOrdersBloc>(context)
        .add(const ActiveOrdersLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const TitleAppBar(title: ActiveOrdersScreen.title),
          BlocBuilder<ActiveOrdersBloc, ActiveOrdersState>(
              builder: (context, state) {
            if (state is ActiveOrdersLoadedState) {
              final rents = state.rents;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: ActiveOrderListCard(rents: rents),
              );
            }
            if (state is ActiveOrdersLoadingFailureState) {
              return _buildFailureContent(theme, context);
            }
            return const LoadingCenterProgress();
          }),
        ],
      ),
    );
  }

  SliverFillRemaining _buildFailureContent(
      ThemeData theme, BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                ActiveOrdersScreen.errorMessage,
                style: theme.textTheme.titleSmall,
              ),
              Text(
                ActiveOrdersScreen.answerMessage,
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ActiveOrdersBloc>(context)
                      .add(const ActiveOrdersLoadEvent());
                },
                child: Text(
                  ActiveOrdersScreen.textButtonMessage,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
