import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/advertisement/layout/advertisement_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/advertisement/layout/advertisement_mobile.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/config/responsive.dart';

class Advertisement extends StatelessWidget {
  const Advertisement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const AdvertisementMobile()
        : const AdvertisementDesktop();
  }
}
