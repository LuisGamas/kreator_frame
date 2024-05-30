// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Color? buttonColor;

  const CustomFilledIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    return IconButton(
      style: IconButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius),
          )),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
