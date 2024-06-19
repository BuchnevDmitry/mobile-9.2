import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/map/map.dart';

class ModalBodyView extends StatefulWidget {
  const ModalBodyView({
    super.key,
    required this.point,
    required this.buttonText,
    required this.mainText,
    required this.receivingMethod,
  });

  final MapPoint point;
  final String buttonText;
  final String mainText;
  final int receivingMethod;

  @override
  State<ModalBodyView> createState() => _ModalBodyViewState();
}

class _ModalBodyViewState extends State<ModalBodyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.mainText,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    'Адрес',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xfffaaaaaa),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    widget.point.address,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ButtonPrimary(
                onPressed: _onPressed,
                text: widget.buttonText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    final rout = context.router;
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final completer = Completer();

    mapBloc.add(MapAddAddressEvent(
      point: widget.point,
      type: widget.receivingMethod,
      completer: completer,
    ));
    await completer.future;

    mapBloc.add(MapLoadAddressEvent());

    await rout.maybePop();
    await rout.maybePop();
  }
}
