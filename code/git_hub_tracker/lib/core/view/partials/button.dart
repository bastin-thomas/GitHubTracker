import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

@immutable
class Button extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const Button({required this.label, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kVerticalSpacer / 2),
        decoration: kBoxDecoration,
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
