import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';

import 'items/freetalent_banner_desktop_widget.dart';
import 'items/freetalent_banner_mobile_widget.dart';

class FreetalentJobSeekerBannerWidget extends StatelessWidget {
  const FreetalentJobSeekerBannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const FreeTalentBannerMobileWidget()
        : const FreetalentBannerDesktopWidget();
  }
}
