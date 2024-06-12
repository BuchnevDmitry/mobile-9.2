import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/user/user.dart';

@RoutePage()
class HistoryOrdersScreen extends StatefulWidget {
  const HistoryOrdersScreen({
    super.key,
  });

  static const String title = 'История заказов';

  @override
  State<HistoryOrdersScreen> createState() => _HistoryOrdersScreenState();
}

class _HistoryOrdersScreenState extends State<HistoryOrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryOrdersBloc>(context)
        .add(const HistoryOrdersLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const TitleAppBar(title: HistoryOrdersScreen.title),
          BlocBuilder<HistoryOrdersBloc, HistoryOrdersState>(
            builder: (context, state) {
              if (state is HistoryOrdersLoadingFailureState) {
                return _buildFailureContent(theme, context);
              }
              if (state is HistoryOrdersLoadedState) {
                final rents = state.rents;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: HistoryOrderListCard(
                    rents: rents,
                  ),
                );
              }
              return const LoadingCenterProgress();
            },
          ),
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
                  BlocProvider.of<HistoryOrdersBloc>(context)
                      .add(const HistoryOrdersLoadEvent());
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
