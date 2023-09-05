import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';

class AdvertisementMobile extends StatelessWidget {
  const AdvertisementMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: 550,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColor.primary,
      ),
      child: SizedBox(
          width: screenSize.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
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
                child: const SizedBox(
                  child: AutoSizeText(
                    "Kini, kamu bisa pilih dan rekrut tenaga kerja yang berpengalaman dalam hitungan menit!",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SmallButton(
                text: 'Coba Sekarang',
                onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webTryNow,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          widget: 'advertisement',
                          screen: 'home')));
                  KukerjaEnv.launchKukerjaAppLink();
                },
              ),
              Image.asset('assets/images/mudah-jadi-nyata-2.png',
                  fit: BoxFit.fill),
            ],
          )),
    );
  }
}
