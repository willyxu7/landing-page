import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../landing_page/style/app_color.dart';

class JobSeekerCvHeaderWidget extends StatelessWidget {
  final String jobSeekerName;
  final String jobSeekerExperience;

  const JobSeekerCvHeaderWidget(
      {required this.jobSeekerName,
      required this.jobSeekerExperience,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Halo',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            'Saya $jobSeekerName',
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            'Pengalaman $jobSeekerExperience',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}
