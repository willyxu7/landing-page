import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SmallLoadingIconButton extends StatefulWidget {
  final String text;
  final Function() onPress;
  final double fontSize;
  final Size buttonSize;
  final Icon icon;
  final bool isLoading;

  const SmallLoadingIconButton(
      {required this.text,
      required this.onPress,
      required this.icon,
      this.fontSize = 16,
      this.buttonSize = const Size(190, 50),
      this.isLoading = false,
      Key? key})
      : super(key: key);

  @override
  _SmallLoadingIconButtonState createState() => _SmallLoadingIconButtonState();
}

class _SmallLoadingIconButtonState extends State<SmallLoadingIconButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.isLoading ? () {} : widget.onPress,
      icon: widget.isLoading
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : widget.icon,
      label: Text(widget.text),
      style: ElevatedButton.styleFrom(
          primary: AppColor.secondary,
          textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize,
              fontFamily: 'Quicksand'),
          minimumSize: widget.buttonSize,
          side: const BorderSide(color: Colors.transparent)),
    );
  }
}
