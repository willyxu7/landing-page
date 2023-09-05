import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SmallLoadingButton extends StatefulWidget {
  final String text, loadingText;
  final Function()? onPressed;
  final double fontSize;
  final Size buttonSize;
  final bool isLoading;

  const SmallLoadingButton(
      {required this.text,
        this.loadingText = "Loading",
      required this.onPressed,
      this.fontSize = 16,
      this.buttonSize = const Size(190, 50),
      required this.isLoading,
      Key? key})
      : super(key: key);

  @override
  _SmallLoadingButtonState createState() => _SmallLoadingButtonState();
}

class _SmallLoadingButtonState extends State<SmallLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColor.secondary,
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.fontSize,
                fontFamily: 'Quicksand'),
            minimumSize: widget.buttonSize,
            side: const BorderSide(color: Colors.transparent)),
        onPressed: widget.onPressed,
        child: widget.isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.loadingText,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize,
                        fontFamily: 'Quicksand'),
                  )
                ],
              )
            : Text(widget.text));
  }
}
