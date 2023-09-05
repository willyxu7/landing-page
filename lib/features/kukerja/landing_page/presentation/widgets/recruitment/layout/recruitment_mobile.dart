import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/recruitment/layout/recruitment_container_mobile.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';

class RecruitmentMobile extends StatelessWidget {
  const RecruitmentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.85,
      padding: const EdgeInsets.all(8.0),
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RecruitmentContainerMobile(
              screenSize: screenSize,
              title: 'Sebagai Pemberi Kerja',
              avatarPath: 'assets/images/pemberi-kerja.png',
              onPress: () {
                PostActivityUseCase.exec(ActivityRequest(
                    type: ActivityTypeUtil.webJoinAsEmployer,
                    extra: ActivityExtraRequest(
                        state: 'tap', widget: 'recruitment', screen: 'home')));
                KukerjaEnv.launchKukerjaAppLink;
              },
              buttonText: 'Gabung'),
          const VerticalDivider(
            color: AppColor.primary,
            thickness: 4,
            indent: 24,
            endIndent: 24,
          ),
          RecruitmentContainerMobile(
              screenSize: screenSize,
              title: 'Sebagai Pekerja Elite',
              avatarPath: 'assets/images/pekerja-elite.png',
              onPress: () {
                PostActivityUseCase.exec(ActivityRequest(
                    type: ActivityTypeUtil.webJoinAsEliteJobSeeker,
                    extra: ActivityExtraRequest(
                        state: 'tap', widget: 'recruitment', screen: 'home')));
                KukerjaEnv.launchKukerjaAppLink;
              },
              buttonText: 'Gabung'),
        ],
      ),
    );
  }
}
