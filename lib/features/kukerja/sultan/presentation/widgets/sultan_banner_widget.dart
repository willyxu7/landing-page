import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';

import 'items/sultan_banner_desktop_widget.dart';
import 'items/sultan_banner_mobile_widget.dart';

class SultanBannerWidget extends StatelessWidget {
  const SultanBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const SultanBannerMobileWidget()
        : const SultanBannerDesktopWidget();
  }
}
