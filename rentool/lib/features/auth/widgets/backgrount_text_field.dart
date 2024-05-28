import 'package:flutter/material.dart';

class GreyTextField extends StatefulWidget {
  const GreyTextField({
    super.key,
    required String hintText,
    required TextEditingController controller,
  })  : _hintText = hintText,
        _controller = controller;

  final String _hintText;
  final TextEditingController _controller;

  @override
  State<GreyTextField> createState() => _GreyTextFieldState();
}

class _GreyTextFieldState extends State<GreyTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        // ignore: use_full_hex_values_for_flutter_colors
        color: Color(0xffff3f4f5),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: SizedBox(
        height: 24,
        child: TextFormField(
          controller: widget._controller,
          style: theme.textTheme.bodyMedium,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: theme.textTheme.labelSmall,
            hintText: widget._hintText,
          ),
        ),
      ),
    );
  }
}
