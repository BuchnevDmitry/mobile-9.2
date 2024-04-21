import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        // ignore: use_full_hex_values_for_flutter_colors
        color: Color(0xffff3f4f5),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: SizedBox(
        height: 20,
        child: TextField(
          style: theme.textTheme.bodyMedium,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const InkWell(
                child: Icon(Icons.search),
              ),
              hintText: 'Поиск',
              hintStyle: theme.textTheme.labelMedium),
        ),
      ),
    );
  }
}
