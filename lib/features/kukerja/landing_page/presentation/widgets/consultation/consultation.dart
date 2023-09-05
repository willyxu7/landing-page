import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/consultation/layout/consultation_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/consultation/layout/consultation_mobile.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/config/responsive.dart';

class Consultation extends StatelessWidget {
  const Consultation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      child: ResponsiveWidget.isSmallScreen(context)
          ? const ConsultationMobile()
          : const ConsultationDesktop(),
    );
  }
}
