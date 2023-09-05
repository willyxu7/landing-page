import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  final String text;
  final Color? textColor;

  const Heading2({required this.text, this.textColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat'),
    );
  }
}
