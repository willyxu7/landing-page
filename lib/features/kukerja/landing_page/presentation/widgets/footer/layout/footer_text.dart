import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

class FooterText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Function() onTap;
  final bool isCanHover;

  const FooterText(
      {required this.text,
      this.fontSize = 12,
      this.fontWeight = FontWeight.normal,
      required this.onTap,
      this.isCanHover = true,
      Key? key})
      : super(key: key);

  @override
  State<FooterText> createState() => _FooterTextState();
}

class _FooterTextState extends State<FooterText> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
      child: InkWell(
          onHover: (hovered) {
            widget.isCanHover
                ? setState(() {
                    isHover = hovered;
                  })
                : () {};
          },
          onTap: widget.onTap,
          child: AutoSizeText(
            widget.text,
            style: TextStyle(
                color: isHover ? AppColor.primary : Colors.white,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight),
          )),
    );
  }
}
