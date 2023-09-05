import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class MediumTextIconButton extends StatefulWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Function() onPress;
  final IconData icon;
  final Color iconColor;

  const MediumTextIconButton(
      {required this.text,
      this.foregroundColor = Colors.black,
      this.backgroundColor = const Color(0xffe5e9f2),
      required this.onPress,
      required this.icon,
      this.iconColor = Colors.black,
      Key? key})
      : super(key: key);

  @override
  State<MediumTextIconButton> createState() => _MediumTextIconButtonState();
}

class _MediumTextIconButtonState extends State<MediumTextIconButton> {
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
        child: Row(
          children: [
            Text(
              widget.text,
              style: TextStyle(color: _isHovered ? Colors.white : widget.foregroundColor, fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(width: 10),
            Icon(
              widget.icon,
              color: _isHovered ? Colors.white : widget.foregroundColor, size: 15,
            )
          ],
        ),
      ),
    );

    // return TextButton.icon(
    //     onHover: (hovered) {
    //       setState(() {
    //         _isHovered = hovered;
    //       });
    //     },
    //     onPressed: widget.onPress,
    //     icon: AutoSizeText(
    //       widget.text,
    //       maxLines: 1,
    //       style: GoogleFonts.montserrat(
    //           textStyle:
    //               const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
    //     ),
    //     label: Icon(
    //       widget.icon,
    //       color: _isHovered ? Colors.white : widget.iconColor,
    //     ),
    //     style: ButtonStyle(
    //       animationDuration: const Duration(milliseconds: 300),
    //       alignment: Alignment.center,
    //       foregroundColor: MaterialStateProperty.all<Color>(_isHovered ? Colors.white : widget.foregroundColor),
    //       backgroundColor: MaterialStateProperty.all<Color>(_isHovered ? AppColor.secondary : widget.backgroundColor),
    //       padding: MaterialStateProperty.all<EdgeInsets>(
    //           const EdgeInsets.symmetric(vertical: 25, horizontal: 25)),
    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //           RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(50),
    //       )),
    //     ));
  }
}
