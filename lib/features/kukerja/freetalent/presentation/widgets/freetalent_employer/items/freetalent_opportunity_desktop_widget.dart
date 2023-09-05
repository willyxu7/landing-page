import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';

import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../core/widgets/heading_3.dart';
import '../../../../../../../core/widgets/large_button.dart';
import '../../../../../../../core/widgets/large_outline_button.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../../landing_page/style/app_color.dart';

class FreetalentOpportunityDesktopWidget extends StatelessWidget {
  const FreetalentOpportunityDesktopWidget({Key? key}) : super(key: key);

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
                'DISCOVER THE TALENT TO HELP YOU BUILD AND GROW',
            textAlign: TextAlign.center),
            const SizedBox(
              height: 12,
            ),
            const Text(
                "There's no promises and salary. The talent is 100% FREE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                )),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LargeButton(text: 'Sign Up', onPress: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webSignUp,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          widget: 'banner',
                          screen: 'freetalents-emp')));
                  KukerjaEnv.launchFreetalentWaLink();
                }),
                const SizedBox(
                  width: 28,
                ),
                LargeOutlineButton(
                  text: 'How it works',
                  onPress: () {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webHowItWorks,
                        extra: ActivityExtraRequest(
                            state: 'tap',
                            widget: 'banner',
                            screen: 'freetalents-emp')));
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
