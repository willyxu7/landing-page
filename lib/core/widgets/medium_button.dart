import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class MediumButton extends StatefulWidget {
  final String text;
  final Function() onPress;

  const MediumButton({
    required this.text,
    required this.onPress,
    Key? key}) : super(key: key);

  @override
  _MediumButtonState createState() => _MediumButtonState();
}

class _MediumButtonState extends State<MediumButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColor.secondary,
            textStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Quicksand'),
            minimumSize: const Size(170, 50),
            side: const BorderSide(color: Colors.transparent)),
        onPressed: widget.onPress,
        child: Text(widget.text));
  }
}
