import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:provider/provider.dart';

import '../../../../../../../env/kukerja_env.dart';
import '../../../providers/applicant_provider.dart';

class ApplicantHeaderDesktopWidget extends StatelessWidget {
  final String jobTitle;
  final String employerName;
  final String applicantsLength;
  final String totalApplicant;

  const ApplicantHeaderDesktopWidget(
      {required this.jobTitle,
      required this.employerName,
      required this.applicantsLength,
      required this.totalApplicant,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48, bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 16 : 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  children: [
                    const TextSpan(text: 'Kandidat yang mendaftar sebagai '),
                    TextSpan(
                        text: jobTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' di '),
                    TextSpan(
                        text: employerName,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),
          ),
          Flexible(
            child: TextButton(
                onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      detail: context.read<ApplicantProvider>().id,
                      type: ActivityTypeUtil.webSeeAllApplicants,
                      extra: ActivityExtraRequest(
                          state: 'tap', screen: 'applicant', widget: 'see all')));
                  KukerjaEnv.launchKukerjaAppLink();
                },
                child: Text(
                  'Lihat Semua ($totalApplicant)',
                  style: const TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
      // child: Column(
      //   children: [
      //     Text(
      //       'Lowongan: ' + jobTitle,
      //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       textAlign: TextAlign.center,
      //     ),
      //     Text(
      //       'di ' + employerName,
      //       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //       textAlign: TextAlign.center,
      //     ),
      //     const SizedBox(height: 24,),
      //     Align(
      //       alignment: Alignment.bottomLeft,
      //       child: Text(
      //         'Daftar ' +
      //             applicantsLength +
      //             ' dari ' +
      //             totalApplicant +
      //             ' pelamar',
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
