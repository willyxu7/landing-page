import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';

import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/widgets/large_button.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';


class SultanBannerDesktopWidget extends StatelessWidget {
  const SultanBannerDesktopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight - 60,
      // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Stack(
        children: [
          Positioned(
            bottom: -70,
            right: -110,
            child: Image.asset('assets/images/sultan.png',
                width: SizeConfig.screenWidth < 1280 ? 750 : 900),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: SizeConfig.screenWidth * 0.5,
            padding: const EdgeInsets.only(left: 120, top: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DAPATKAN BANTUAN REKRUTMEN ALA SULTAN',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  height: 38,
                ),
                const Text(
                  'Nikmati proses rekrutmen cepat dan nyaman dengan bantuan rekomendasi dari SQUAD Kerja.',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    LargeButton(
                        text: 'JADI SULTAN 1 HARI',
                        sizeWidth: 320,
                        sizeHeight: 80,
                        onPress: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webViewSultan,
                              extra: ActivityExtraRequest(
                                  state: 'tap',
                                  widget: 'button',
                                  screen: 'sultan')));
                          KukerjaEnv.launchSultanWaLink();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
