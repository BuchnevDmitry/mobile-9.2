import 'package:flutter/material.dart';
import 'package:rentool/common/widgets/widgets.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BaseContainer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
              'assets/images/black-friday-coupon-ideas_b-625x328.png'),
        ),
      ),
    );
  }
}
