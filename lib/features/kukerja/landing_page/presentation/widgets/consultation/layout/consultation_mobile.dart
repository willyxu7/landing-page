import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/wave_clipper_two.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';

class ConsultationMobile extends StatelessWidget {
  const ConsultationMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            width: screenSize.width,
            height: 700,
            decoration: const BoxDecoration(color: AppColor.primary),
            child: Container(),
          ),
        ),
        Center(
          child: Container(
            width: screenSize.width * 0.85,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 16),
                      child: const AutoSizeText(
                        'Butuh bantuan untuk cari pekerja atau cari pekerjaan?',
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const AutoSizeText(
                        "Dengan bantuan SQUAD KERJA, kamu bisa dapatkan pekerja atau pekerjaan yang spesifik, semua jadi lebih mudah!",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SmallButton(
                      text: 'Hubungi SQUAD KERJA',
                      onPressed: () {
                        PostActivityUseCase.exec(ActivityRequest(
                            type: ActivityTypeUtil.webContactSquadKerja,
                            extra: ActivityExtraRequest(
                                state: 'tap',
                                widget: 'consultant',
                                screen: 'home')));
                        KukerjaEnv.launchKukerjaWaLink();
                      },
                    )
                  ],
                ),
                SizedBox(height: screenSize.height * 0.03),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        // fit: BoxFit.cover,
                        image: AssetImage('assets/images/web-call-me-2.png')),
                  ),
                  // width: screenSize.width * 0.4,
                  height: screenSize.height * 0.4,
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
