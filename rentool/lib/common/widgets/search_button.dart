import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/router/router.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    this.withBackButton = false,
  });

  final bool withBackButton;
  static const String hintText = 'Поиск';

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: _getMargin(),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        // ignore: use_full_hex_values_for_flutter_colors
        color: Color(0xffff3f4f5),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: SizedBox(
        height: 24,
        child: TextField(
          onSubmitted: _search,
          style: theme.textTheme.bodyMedium,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const InkWell(
                child: Icon(Icons.search),
              ),
              hintText: SearchButton.hintText,
              hintStyle: theme.textTheme.labelSmall),
        ),
      ),
    );
  }

  Future<void> _search(String searchText) async {
    await context.router.push(ListToolsSearchRoute(searchText: searchText));
  }

  EdgeInsets _getMargin() => widget.withBackButton
      ? const EdgeInsets.only(top: 12, bottom: 12, right: 24)
      : const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
}
