import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';
import '../utils/company_information_util.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double fontSize;
  final FontWeight? fontWeight;

  const PrimaryOutlinedButton({
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
    this.fontWeight,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {
      onPressed();
    },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColor.primary
        ),
        primary: AppColor.primary.withOpacity(0.3)
      ), child: Text(
      text,
      style: TextStyle(
          color: AppColor.primary,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: CompanyInformationUtil.secondaryFontFamily),
    )
    );
  }
}
