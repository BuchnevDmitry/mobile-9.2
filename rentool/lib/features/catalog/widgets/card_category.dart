import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, required this.cartegory});

  final String cartegory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          cartegory,
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
