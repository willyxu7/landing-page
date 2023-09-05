import 'package:flutter/material.dart';

class LargeOutlineButton extends StatefulWidget {
  final String text;
  final Function() onPress;
  final Color primaryColor;
  final Color borderColor;

  const LargeOutlineButton({
    required this.text,
    required this.onPress,
    this.primaryColor = Colors.white,
    this.borderColor = Colors.white,

    Key? key}) : super(key: key);

  @override
  _LargeOutlineButtonState createState() => _LargeOutlineButtonState();
}

class _LargeOutlineButtonState extends State<LargeOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: widget.primaryColor,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Quicksand'),
            minimumSize: const Size(200, 60),
            side: BorderSide(color: widget.borderColor, width: 2)
        ),
        onPressed: widget.onPress,
        child: Text(widget.text)
    );
  }
}
