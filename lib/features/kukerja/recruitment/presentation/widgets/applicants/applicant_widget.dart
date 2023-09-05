import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/applicants/items/applicant_desktop_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/applicants/items/applicant_mobile_widget.dart';
import 'package:flutter/material.dart';

class ApplicantWidget extends StatelessWidget {
  const ApplicantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveWidget.isSmallScreen(context)
          ? const ApplicantMobileWidget()
          : const ApplicantDesktopWidget(),
    );
  }
}
