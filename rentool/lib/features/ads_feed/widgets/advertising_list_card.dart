import 'package:flutter/material.dart';
import 'package:rentool/features/ads_feed/widgets/widgets.dart';

class AdvertisingListCard extends StatelessWidget {
  const AdvertisingListCard({
    super.key,
    required this.advertisingCardResources,
  });

  final List<String> advertisingCardResources;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      scrollDirection: Axis.horizontal,
      itemCount: advertisingCardResources.length,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (context, index) => AdvertisingCard(
        imageUrl: advertisingCardResources[index],
      ),
    );
  }
}
