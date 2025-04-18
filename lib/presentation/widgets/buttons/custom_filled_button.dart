// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;

  const CustomFilledButton({
    super.key, 
    required this.onPressed, 
    required this.text, 
    required this.buttonColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20);
    return FilledButton(
      onPressed: onPressed, 
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
      )),
      child: Text(text, style: TextStyle(color: textColor))
    );
  }
}
