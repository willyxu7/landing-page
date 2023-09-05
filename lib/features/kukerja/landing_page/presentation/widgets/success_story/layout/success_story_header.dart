import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/widgets/medium_text_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/config/responsive.dart';

class SuccessStoryHeader extends StatelessWidget {
  const SuccessStoryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          const AutoSizeText('Success Story',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary)),
          ResponsiveWidget.isSmallScreen(context)
              ? Container()
              : MediumTextButton(text: 'All Stories', onPress: () {}),
        ],
      ),
    );
  }
}
