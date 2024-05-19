import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/widgets/widgets.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
    this.buttonBack = false,
  });

  final bool buttonBack;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.buttonBack) {
      return _buildWithBack(context);
    } else {
      return _buildDefault(theme);
    }
  }

  SliverAppBar _buildDefault(ThemeData theme) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: theme.cardColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      bottom: const PreferredSize(
        preferredSize: Size.fromRadius(10),
        child: SearchButton(),
      ),
    );
  }

  SliverAppBar _buildWithBack(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromRadius(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
            ),
            const Expanded(
                child: SearchButton(
              withBackButton: true,
            ))
          ],
        ),
      ),
    );
  }
}
