import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/widgets/large_button.dart';
import '../../../../../../../core/widgets/large_outline_button.dart';
import '../../../../../landing_page/style/app_color.dart';

class FreetalentBannerDesktopWidget extends StatelessWidget {
  const FreetalentBannerDesktopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HIRING WITH UNLIMITED RESOURCES',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  height: 38,
                ),
                const Text(
                  'Empowering you with fresh graduates to help you complete simple task without hassle',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    LargeButton(
                        text: 'Start Now',
                        onPress: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webStartNow,
                              extra: ActivityExtraRequest(
                                  state: 'tap',
                                  widget: 'banner',
                                  screen: 'freetalents-emp')));
                          QR.to('/freetalents-emp/create');
                        }),
                    const SizedBox(
                      width: 28,
                    ),
                    LargeOutlineButton(
                      text: 'Ask Us',
                      onPress: () {
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
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/background-banner-1.png'),
                  Image.asset('assets/images/banner-1.png')
                ],
              ))
        ],
      ),
    );
  }
}
