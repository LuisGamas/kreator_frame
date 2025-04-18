// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomOutlineIconTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final String text;
  final Color color;
  final double radius;

  const CustomOutlineIconTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
    this.radius = 20,
  });

  @override
  /// Builds a custom outlined button with an icon and text.
  /// 
  /// This widget returns an [OutlinedButton] with an icon and a text label.
  /// The button's appearance can be customized with a specified [color] for the
  /// text, a [radius] for the border's corner rounding, and a [shape] defined
  /// by a [RoundedRectangleBorder]. The button is enabled or disabled based on
  /// the [onPressed] callback, which is triggered when the button is pressed.
  /// The [icon] and [text] are displayed within the button, with the text
  /// styled using the provided color.
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      )),
      icon: icon,
      label: Text(text, style: TextStyle(color: color))
    );
  }
}