import 'package:flutter/material.dart';

class Heading4 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? textColor;

  const Heading4(
      {required this.text,
      this.textAlign = TextAlign.left,
      this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat'),
    );
  }
}
