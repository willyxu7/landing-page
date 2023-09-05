import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SmallTextButton extends StatefulWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color hoveredForegroundColor;
  final Color hoveredBackgroundColor;
  final Function() onPress;
  final bool isRound;

  const SmallTextButton(
      {required this.text,
      this.foregroundColor = Colors.black,
      this.backgroundColor = const Color(0xffe5e9f2),
      this.hoveredForegroundColor = Colors.white,
      this.hoveredBackgroundColor = AppColor.secondary,
      required this.onPress,
      this.isRound = true,
      Key? key})
      : super(key: key);

  const SmallTextButton.square({
    required this.text,
    this.foregroundColor = AppColor.secondary,
    this.backgroundColor = Colors.transparent,
    this.hoveredForegroundColor = Colors.white,
    this.hoveredBackgroundColor = AppColor.secondary,
    this.isRound = false,
    required this.onPress,
    Key? key
  }) : super(key: key);

  @override
  State<SmallTextButton> createState() => _SmallTextButtonState();
}

class _SmallTextButtonState extends State<SmallTextButton> {
  bool _isHovered = false;

  MaterialStateProperty<OutlinedBorder> renderShape() {
    late MaterialStateProperty<OutlinedBorder> shapeWidget;

    if (widget.isRound) {
      shapeWidget = MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ));
    } else {
      shapeWidget = MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ));
    }

    return shapeWidget;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onHover: (hovered) {
          setState(() {
            _isHovered = hovered;
          });
        },
        onPressed: widget.onPress,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          foregroundColor: MaterialStateProperty.all<Color>(
              _isHovered ? widget.hoveredForegroundColor : widget.foregroundColor),
          backgroundColor: MaterialStateProperty.all<Color>(
              _isHovered ? widget.hoveredBackgroundColor : widget.backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 20, horizontal: 25)),
          shape: renderShape(),
        ),
        child: AutoSizeText(
          widget.text,
          maxLines: 1,
          style: GoogleFonts.montserrat(
              textStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ));
  }
}
