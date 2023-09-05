import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';
import 'job_seeker_cv_widget.dart';
import 'job_seeker_list_container_widget.dart';

class OldRecommendedJobSeekerDesktopWidget extends StatelessWidget {
  const OldRecommendedJobSeekerDesktopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: SizeConfig.screenWidth * 0.80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey.withOpacity(0.5)))),
            child: Row(
              children: const [Chip(label: Text('Gaji'))],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Flexible(flex: 4, child: JobSeekerListContainerWidget()),
                Flexible(flex: 6, child: JobSeekerCvWidget())
              ],
            ),
          )
        ],
      ),
    );
  }
}
