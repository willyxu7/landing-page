import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/company_information_util.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';

class SecondaryTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double fontSize;
  final FontWeight? fontWeight;

  const SecondaryTextButton(
      {required this.text,
        required this.onPressed,
        this.fontSize = 16,
        this.fontWeight,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
            primary: AppColor.secondary.withOpacity(0.3)
        ),
        child: Text(
          text,
          style: TextStyle(
              color: AppColor.secondary,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontFamily: CompanyInformationUtil.secondaryFontFamily),
        ));
  }
}
