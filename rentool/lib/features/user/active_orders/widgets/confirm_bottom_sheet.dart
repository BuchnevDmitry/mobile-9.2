import 'package:flutter/material.dart';
import 'package:rentool/common/common.dart';

class ConfirmBottomSheet extends StatefulWidget {
  const ConfirmBottomSheet({
    super.key,
    required this.buttonText,
    required this.mainText,
    required this.onPressed,
    required this.questionText,
  });

  final String buttonText;
  final String mainText;
  final String questionText;
  final onPressed;

  @override
  State<ConfirmBottomSheet> createState() => _ConfirmBottomSheetState();
}

class _ConfirmBottomSheetState extends State<ConfirmBottomSheet> {
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
              Row(
                children: [
                  Text(
                    widget.questionText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ButtonPrimary(
                onPressed: widget.onPressed,
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
}
