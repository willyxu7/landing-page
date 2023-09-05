import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SmallButton extends StatefulWidget {
  final String text;
  final Function()? onPressed;
  final double fontSize;
  final Size buttonSize;

  const SmallButton({
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
    this.buttonSize = const Size(190, 50),
    Key? key}) : super(key: key);

  @override
  _SmallButtonState createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColor.secondary,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: widget.fontSize, fontFamily: 'Quicksand'),
            minimumSize: widget.buttonSize,
            side: const BorderSide(color: Colors.transparent)),
        onPressed: widget.onPressed,
        child: Text(widget.text));
  }
}
