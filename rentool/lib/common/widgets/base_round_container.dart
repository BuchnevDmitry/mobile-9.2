import 'package:flutter/material.dart';

class BaseRoundContainer extends StatelessWidget {
  const BaseRoundContainer(
      {super.key,
      required this.child,
      this.width,
      this.height,
      this.margin,
      this.decoration});

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration:
          decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
