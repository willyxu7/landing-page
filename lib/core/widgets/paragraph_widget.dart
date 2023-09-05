import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  final String text;
  FontWeight? fontWeight;
  final double marginLeft, marginTop, marginRight, marginBottom;
  final TextAlign textAlign;

  ParagraphWidget(this.text,
      {this.marginLeft = 0,
        this.marginTop = 0,
        this.marginRight = 0,
        this.marginBottom = 0,
        this.fontWeight,
        this.textAlign = TextAlign.left,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: marginLeft,
          top: marginTop,
          right: marginRight,
          bottom: marginBottom),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(fontSize: 18, fontWeight: fontWeight, color: Colors.black),
      ),
    );
  }
}