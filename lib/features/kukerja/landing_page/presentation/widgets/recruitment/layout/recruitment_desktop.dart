import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/recruitment/layout/recruitment_container_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../env/kukerja_env.dart';


class RecruitmentDesktop extends StatelessWidget {
  const RecruitmentDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.85,
      height: 380,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RecruitmentContainerDesktop(
              screenSize: screenSize,
              title: 'Sebagai Pemberi Kerja',
              avatarPath: 'assets/images/pemberi-kerja.png',
              onPress: () {
                PostActivityUseCase.exec(ActivityRequest(
                    type: ActivityTypeUtil.webJoinAsEmployer,
                    extra: ActivityExtraRequest(
                        state: 'tap', widget: 'recruitment', screen: 'home')));
                KukerjaEnv.launchKukerjaAppLink();
              },
              buttonText: 'Gabung'),
          const VerticalDivider(
            color: AppColor.primary,
            thickness: 4,
            indent: 24,
            endIndent: 24,
          ),
          RecruitmentContainerDesktop(
              screenSize: screenSize,
              title: 'Sebagai Pekerja Elite',
              avatarPath: 'assets/images/pekerja-elite.png',
              onPress: () {
                PostActivityUseCase.exec(ActivityRequest(
                    type: ActivityTypeUtil.webJoinAsEliteJobSeeker,
                    extra: ActivityExtraRequest(
                        state: 'tap', widget: 'recruitment', screen: 'home')));
                KukerjaEnv.launchKukerjaAppLink();
              },
              buttonText: 'Gabung'),
        ],
      ),
    );
  }
}
