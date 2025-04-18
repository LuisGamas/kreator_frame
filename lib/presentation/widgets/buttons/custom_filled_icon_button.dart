// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Color? buttonColor;

  const CustomFilledIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(13);
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radius),
        )),
      icon: icon,
    );
  }
}
