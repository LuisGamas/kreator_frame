// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledIconTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Widget label;
  final Color? buttonColor;

  const CustomFilledIconTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radius),
        )),
      icon: icon,
      label: label,
    );
  }
}