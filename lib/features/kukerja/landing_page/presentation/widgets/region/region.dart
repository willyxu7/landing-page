import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/section_header.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/region/layout/region_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/region/layout/region_mobile.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:flutter/material.dart';

class Region extends StatelessWidget {
  const Region({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth * 0.85,
      margin: const EdgeInsets.only(bottom: 120),
      child: Column(
        children: [
          const SectionHeader(text: 'Kami hadir di . . .'),
          const SizedBox(
            height: 30,
          ),
          ResponsiveWidget.isSmallScreen(context)
              ? const RegionMobile()
              : const RegionDesktop()
        ],
      ),
    );
  }
}
