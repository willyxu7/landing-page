import 'package:flutter/material.dart';

class SmallOutlineButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final Color primaryColor;
  final Color borderColor;
  final Size buttonSize;
  final double fontSize;

  const SmallOutlineButton({
    required this.text,
    required this.onPressed,
    this.primaryColor = Colors.white,
    this.borderColor = Colors.white,
    this.buttonSize = const Size(190, 50),
    this.fontSize = 18,
    Key? key}) : super(key: key);

  @override
  _SmallOutlineButtonState createState() => _SmallOutlineButtonState();
}

class _SmallOutlineButtonState extends State<SmallOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: widget.primaryColor,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.fontSize, fontFamily: 'Quicksand'),
            minimumSize: widget.buttonSize,
            side: BorderSide(color: widget.borderColor, width: 2)
        ),
        onPressed: widget.onPressed,
        child: Text(widget.text)
    );
  }
}
