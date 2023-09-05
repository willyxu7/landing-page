import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../core/widgets/heading_2.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../../landing_page/style/app_color.dart';

class FreeTalentBannerMobileWidget extends StatelessWidget {
  const FreeTalentBannerMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(
          vertical: 40.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Heading2(text: 'HIRING WITH UNLIMITED RESOURCES'),
          const SizedBox(
            height: 28,
          ),
          const Text(
            'Empowering you with fresh graduates to help you complete simple task without hassle',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 60,
          ),
          SmallButton(text: 'Start Now', onPressed: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webStartNow,
                extra: ActivityExtraRequest(
                    state: 'tap',
                    widget: 'banner',
                    screen: 'freetalents-emp')));
            KukerjaEnv.launchFreetalentWaLink();
          }),
          const SizedBox(
            height: 28,
          ),
          SmallOutlineButton(
            text: 'Ask Us',
            onPressed: () {
              PostActivityUseCase.exec(ActivityRequest(
                  type: ActivityTypeUtil.webAskUs,
                  extra: ActivityExtraRequest(
                      state: 'tap',
                      widget: 'banner',
                      screen: 'freetalents-emp')));
              KukerjaEnv.launchFreetalentWaLink();
            },
            primaryColor: AppColor.secondary,
            borderColor: AppColor.secondary,
          ),
        ],
      ),
    );
  }
}
