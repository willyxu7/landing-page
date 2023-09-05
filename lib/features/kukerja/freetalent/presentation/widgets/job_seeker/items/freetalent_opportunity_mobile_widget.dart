import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../core/widgets/heading_3.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../../landing_page/style/app_color.dart';


class FreetalentOpportunityMobileWidget extends StatelessWidget {
  const FreetalentOpportunityMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        width: SizeConfig.screenWidth * 0.85,
        padding: const EdgeInsets.symmetric(
            vertical: 80.0, horizontal: 40.0),
        child: Column(
          children: [
            const Heading3(
                text:
                'DISCOVER THE REAL EXPERIENCE AND OPPORTUNITY',
                textAlign: TextAlign.center),
            const SizedBox(
              height: 12,
            ),
            const Text(
                "All opportunity you've got is voluntary, you will get experiences and chance to upgrade your skills",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                )),
            const SizedBox(
              height: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallButton(text: 'Sign Up', onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webSignUp,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          widget: 'banner',
                          screen: 'freetalents-js')));
                  KukerjaEnv.launchFreetalentWaLink();
                }),
                const SizedBox(
                  height: 28,
                ),
                SmallOutlineButton(
                  text: 'How it works',
                  onPressed: () {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webHowItWorks,
                        extra: ActivityExtraRequest(
                            state: 'tap',
                            widget: 'banner',
                            screen: 'freetalents-js')));
                    KukerjaEnv.launchFreetalentWaLink();
                  },
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                )
              ],
            )
          ],
        ));
  }
}
