// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {

    const radius = Radius.circular(10);

    return FilledButton(

      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
      )),
    
      onPressed: onPressed, 
      child: Text(text, style: TextStyle(color: textColor))
      
    );

  }
}
