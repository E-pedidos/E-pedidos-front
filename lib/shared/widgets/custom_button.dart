import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white),
      ),
    );
  }
}
