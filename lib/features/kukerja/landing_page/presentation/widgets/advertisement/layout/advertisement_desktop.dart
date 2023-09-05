import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/large_button.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../env/kukerja_env.dart';

class AdvertisementDesktop extends StatelessWidget {
  const AdvertisementDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: 500,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      child: SizedBox(
          width: screenSize.width * 0.85,
          child: Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.425,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: screenSize.width * 0.425,
                          child: const SizedBox(
                            child: AutoSizeText(
                              'Rekrutmen lama dan turnover tinggi?',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: screenSize.width * 0.3,
                          child: const AutoSizeText(
                            "Kini, kamu bisa pilih dan rekrut tenaga kerja yang berpengalaman dalam hitungan menit!",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        LargeButton(
                          text: 'Coba Sekarang',
                          onPress: () {
                            PostActivityUseCase.exec(ActivityRequest(
                                type: ActivityTypeUtil.webTryNow,
                                extra: ActivityExtraRequest(
                                    state: 'tap',
                                    widget: 'advertisement',
                                    screen: 'home')));
                            KukerjaEnv.launchKukerjaAppLink();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width * 0.425,
                alignment: Alignment.center,
                child: Image.asset('assets/images/mudah-jadi-nyata-2.png',
                    fit: BoxFit.fill),
              )
              // SizedBox(
              //   width: screenSize.width * 0.425,
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         child: Image.asset('images/iphone.png'),
              //         right: screenSize.width * 0.2125,
              //         bottom: 70,
              //         height: 500,
              //       ),
              //       Positioned(
              //         child: Image.asset('images/iphone.png'),
              //         top: 50,
              //         right: 50,
              //         height: 500,
              //       )
              //     ],
              //   ),
              // )
            ],
          )),
    );
  }
}
