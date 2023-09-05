import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/layout/footer_information.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/config/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: ResponsiveWidget.isSmallScreen(context)
          ? 580
          : SizeConfig.blockSizeVertical * 40,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xff171717),
      ),
      child: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 85,
        child: Column(
          children: const [
            SizedBox(height: 20),
            FooterInformation(),
          ],
        ),
      ),
    );
  }
}
