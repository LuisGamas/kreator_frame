// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;

  const CustomOutlineButton({
    super.key, 
    required this.onPressed, 
    required this.text, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
      ),
      side: BorderSide(
          color: color,
        )
      ), 
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}