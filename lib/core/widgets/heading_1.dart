import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const Heading1(
      {required this.text, this.textAlign = TextAlign.left, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
    );
  }
}
