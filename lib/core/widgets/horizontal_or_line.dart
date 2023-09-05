import 'package:flutter/material.dart';

class HorizontalOrLine extends StatelessWidget {
  final String label;
  final double thickness;
  final Color textColor;
  final Color color;

  const HorizontalOrLine({
    this.color = Colors.black26,
    this.textColor = Colors.black,
    required this.label, required this.thickness, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ),
      Text(label, style: TextStyle(color: textColor),),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ),
    ]);
  }
}
