import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_course_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_education_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_experience_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_header_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_industry_widget.dart';

import '../../../../../../../core/config/size_config.dart';
import 'job_seeker_cv_profile_widget.dart';


class JobSeekerCvWidget extends StatefulWidget {
  static const String route = '/job-seeker-cv';

  const JobSeekerCvWidget({Key? key}) : super(key: key);

  @override
  State<JobSeekerCvWidget> createState() => _JobSeekerCvWidgetState();
}

class _JobSeekerCvWidgetState extends State<JobSeekerCvWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(children: [
          Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-45 / 360),
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                        'assets/images/kukerja_logo.png',
                      width: SizeConfig.screenWidth * 0.3,
                    ),
                  )
              )
          ),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: const [
              JobSeekerCvHeaderWidget(
                  jobSeekerName: 'Gitty Chairunissa',
                  jobSeekerExperience: 'Memasak'),
              SizedBox(height: 24),
              JobSeekerCvProfileWidget(),
              SizedBox(height: 48),
              JobSeekerCvEducationWidget(),
              SizedBox(height: 48),
              JobSeekerCvCourseWidget(),
              SizedBox(height: 48),
              JobSeekerCvExperienceWidget(),
              SizedBox(height: 48),
              JobSeekerCvIndustryWidget(),
            ],
          )
        ],)
    );
  }
}
