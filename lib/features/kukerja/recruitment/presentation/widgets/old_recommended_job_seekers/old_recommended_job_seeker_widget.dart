import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/old_recommended_job_seeker_desktop_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/old_recommended_job_seeker_mobile_widget.dart';


class OldRecommendedJobSeekerWidget extends StatelessWidget {
  const OldRecommendedJobSeekerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const OldRecommendedJobSeekerDesktopWidget()
        : const OldRecommendedJobSeekerMobileWidget()
    ;
  }
}
