import 'package:kukerja_web/core/widgets/section_header.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/recruitment/layout/recruitment_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/recruitment/layout/recruitment_mobile.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:flutter/material.dart';

class Recruitment extends StatelessWidget {
  const Recruitment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SectionHeader(text: 'Sudah Siap Memulai ?'),
          ResponsiveWidget.isSmallScreen(context)
              ? const RecruitmentMobile()
              : const RecruitmentDesktop()
        ],
      ),
    );
  }
}
