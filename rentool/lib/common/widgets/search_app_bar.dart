import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/common/widgets/widgets.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    this.buttonBack = false,
    this.favoriteIcon = false,
  });

  final bool favoriteIcon;
  final bool buttonBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (buttonBack && favoriteIcon) {
      return SliverAppBar(
        pinned: true,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
              )),
              const SizedBox(
                width: 17,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 16,
                child: IconButton(
                  iconSize: 16,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  selectedIcon: Icon(
                    Icons.favorite,
                    color: theme.primaryColor,
                  ),
                  isSelected: false,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
      );
    }
    if (buttonBack) {
      return SliverAppBar(
        pinned: true,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
    } else {
      return SliverAppBar(
        pinned: true,
        backgroundColor: theme.cardColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromRadius(10),
          child: SearchButton(),
        ),
      );
    }
  }
}
