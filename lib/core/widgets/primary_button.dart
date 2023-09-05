import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';
import '../utils/company_information_util.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double fontSize;
  final FontWeight? fontWeight;

  const PrimaryButton(
      {required this.text,
      required this.onPressed,
      this.fontSize = 16,
      this.fontWeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          primary: AppColor.primary
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontFamily: CompanyInformationUtil.secondaryFontFamily),
        ));
  }
}
