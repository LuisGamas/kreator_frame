// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledIconTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double radius;

  const CustomFilledIconTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    this.radius = 20,
  });

  @override
  /// Builds a filled button with an icon and a text label.
  ///
  /// The button is colored with the given [buttonColor], and the text is
  /// colored with the given [textColor]. The button has a circular border
  /// of the given [radius].
  ///
  /// The button is pressed with the given [onPressed] function.
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      )),
      icon: icon,
      label: Text(text, style: TextStyle(color: textColor))
    );
  }
}