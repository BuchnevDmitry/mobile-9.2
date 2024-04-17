import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer(
      {super.key,
      required this.child,
      this.width,
      this.margin,
      this.decoration});

  final Widget child;
  final double? width;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      decoration:
          decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
