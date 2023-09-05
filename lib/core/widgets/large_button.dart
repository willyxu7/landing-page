import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatefulWidget {
  final String text;
  final Function() onPress;
  final double sizeWidth;
  final double sizeHeight;

  const LargeButton(
      {required this.text,
      required this.onPress,
      this.sizeWidth = 200,
      this.sizeHeight = 60,
      Key? key})
      : super(key: key);

  @override
  State<LargeButton> createState() => _LargeButtonState();
}

class _LargeButtonState extends State<LargeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColor.secondary,
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Quicksand'),
            minimumSize: Size(widget.sizeWidth, widget.sizeHeight),
            side: const BorderSide(color: Colors.transparent)),
        onPressed: widget.onPress,
        child: Text(widget.text));
  }
}
