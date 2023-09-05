import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/job_details_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/job_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/size_config.dart';

class JobDetailsDesktopWidget extends StatefulWidget {
  const JobDetailsDesktopWidget({Key? key}) : super(key: key);

  @override
  _JobDetailsDesktopWidgetState createState() =>
      _JobDetailsDesktopWidgetState();
}

class _JobDetailsDesktopWidgetState extends State<JobDetailsDesktopWidget> {
  JobDetailsResponse jobDetailsResponse = JobDetailsResponse();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    jobDetailsResponse = context.watch<JobProvider>().jobDetails;
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 4, right: 4, bottom: 24),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image:
                    NetworkImage(jobDetailsResponse.profileEmployer!.imageUrl!),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            jobDetailsResponse.profileEmployer!.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            'Nama Pekerjaan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            jobDetailsResponse.title!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Deskripsi Pekerjaan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            jobDetailsResponse.description!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Kisaran Gaji',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${jobDetailsResponse.salaryStart} - ${jobDetailsResponse.salaryEnd}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Lokasi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            jobDetailsResponse.location!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 50),
          SmallButton(
            text: 'Lamar Pekerjaan',
            onPressed: () {
              PostActivityUseCase.exec(ActivityRequest(
                  type: ActivityTypeUtil.webApplyJob,
                  detail: context.read<JobProvider>().id,
                  extra: ActivityExtraRequest(
                      state: 'tap', screen: 'job details')));
              KukerjaEnv.launchKukerjaAppLink();
            },
            fontSize: 14,
            buttonSize: const Size(130, 50),
          ),
        ],
      ),
    );
  }
}
