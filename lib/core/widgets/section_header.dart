import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final double fontSize;

  const SectionHeader({required this.text, this.fontSize = 20, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.85,
      child: AutoSizeText(text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat')),
    );
  }
}
