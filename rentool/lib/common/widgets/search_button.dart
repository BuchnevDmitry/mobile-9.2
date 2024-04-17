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
        color: Color(0xffff3f4f5),
        borderRadius: BorderRadius.all(Radius.circular(180)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 12.5,
          ),
          const Icon(Icons.search),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Поиск',
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
