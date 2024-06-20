import 'package:flutter/material.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';

class AdvertisingListCard extends StatelessWidget {
  const AdvertisingListCard({
    super.key,
    required this.advertisings,
  });

  final List<Advertising> advertisings;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      scrollDirection: Axis.horizontal,
      itemCount: advertisings.length,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (context, index) => AdvertisingCard(
        imageUrl: advertisings[index].imageUrl,
      ),
    );
  }
}
