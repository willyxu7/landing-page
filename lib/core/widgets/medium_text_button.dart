import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

class MediumTextButton extends StatefulWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Function() onPress;

  const MediumTextButton(
      {required this.text,
      this.foregroundColor = Colors.black,
      this.backgroundColor = const Color(0xffe5e9f2),
      required this.onPress,
      Key? key})
      : super(key: key);

  @override
  State<MediumTextButton> createState() => _MediumTextButtonState();
}

class _MediumTextButtonState extends State<MediumTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      onHover: (hovered) {
        setState(() {
          _isHovered = hovered;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
            color: _isHovered ? AppColor.secondary : widget.backgroundColor,
            borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          widget.text,
          style: TextStyle(
              color: _isHovered ? Colors.white : widget.foregroundColor,
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
      ),
    );

    // return TextButton(
    //     onHover: (hovered) {
    //       setState(() {
    //         _isHovered = hovered;
    //       });
    //     },
    //     onPressed: widget.onPress,
    //     child: AutoSizeText(
    //       widget.text,
    //       maxLines: 1,
    //       style: GoogleFonts.montserrat(
    //           textStyle:
    //               const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
    //     ),
    //     style: ButtonStyle(
    //       animationDuration: const Duration(milliseconds: 300),
    //       alignment: Alignment.center,
    //       foregroundColor: MaterialStateProperty.all<Color>(_isHovered ? Colors.white : widget.foregroundColor),
    //       backgroundColor: MaterialStateProperty.all<Color>(_isHovered ? AppColor.secondary : widget.backgroundColor),
    //       padding: MaterialStateProperty.all<EdgeInsets>(
    //           const EdgeInsets.symmetric(vertical: 20, horizontal: 35)),
    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //           RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(30),
    //       )),
    //     ));
  }
}
