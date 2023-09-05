import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/layout/footer_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/layout/footer_mobile.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:flutter/material.dart';

class FooterInformation extends StatelessWidget {
  const FooterInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const FooterMobile()
        : const FooterDesktop();
  }
}
