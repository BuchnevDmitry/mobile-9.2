import 'package:flutter/material.dart';
import 'package:rentool/common/widgets/widgets.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BaseRoundContainer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
