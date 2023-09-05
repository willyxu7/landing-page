import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/heading_4.dart';

import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';


class SultanBannerMobileWidget extends StatelessWidget {
  const SultanBannerMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight - 60,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
            child: Column(
              children: [
                const Heading4(
                  text: 'DAPATKAN BANTUAN REKRUTMEN ALA SULTAN',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  'Nikmati proses rekrutmen cepat dan nyaman dengan bantuan rekomendasi dari SQUAD Kerja.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    SmallButton(
                        text: 'JADI SULTAN 1 HARI',
                        buttonSize: const Size(280, 60),
                        onPressed: () {
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
          Positioned(right: -40, bottom: -30,child: Image.asset(
            'assets/images/sultan.png',
            width: 250,
            height: 250,
          ),)
        ],
      ),
    );
  }
}
