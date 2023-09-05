import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import '../../../../../../core/utils/activity_type_util.dart';

import '../../../../../../core/widgets/heading_3.dart';
import '../../../../../../core/widgets/paragraph_widget.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';

class TalentPoolSuccess extends StatefulWidget {
  const TalentPoolSuccess({Key? key}) : super(key: key);

  @override
  State<TalentPoolSuccess> createState() => _TalentPoolSuccessState();
}

class _TalentPoolSuccessState extends State<TalentPoolSuccess> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _clearAccessToken();
  }

  void _clearAccessToken() async {
    await _storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: const EdgeInsets.all(16),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/thumbs-up.png',
            width: 400,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
            height: 24,
          ),
          const Heading3(
            text: 'Terima kasih telah begabung sebagai Elite',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          ParagraphWidget(
            'Pengajuan kamu sedang kami ditinjau dan akan di validasi max 1x24 jam.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          ParagraphWidget(
            'Selanjutnya, masuk untuk bisa mendapatkan undangan interview dan lamar kerja GRATIS tanpa perlu ke lokasi.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          ResponsiveWidget.isSmallScreen(context) ? Column(
            children: [
              SmallOutlineButton(
                buttonSize: const Size.fromHeight(50),
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  text: "Cek Wawancara",
                  onPressed: () {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webCheckInterview,
                        extra: ActivityExtraRequest(
                            state: 'tap',
                            widget: 'button',
                            screen: 'talent pool')));
                    KukerjaEnv.launchKukerjaAppLink();
                  }),
              const SizedBox(height: 16),
              SmallButton(
                buttonSize: const Size.fromHeight(50),
                text: "Lihat Lowongan",
                onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webCheckJobs,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          widget: 'button',
                          screen: 'talent pool')));
                  KukerjaEnv.launchKukerjaAppLink();
                },
              )
            ],
          ) :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallOutlineButton(
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  text: "Cek Wawancara",
                  onPressed: () {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webCheckInterview,
                        extra: ActivityExtraRequest(
                            state: 'tap',
                            widget: 'button',
                            screen: 'talent pool')));
                    KukerjaEnv.launchKukerjaAppLink();
                  }),
              const SizedBox(width: 16),
              SmallButton(
                text: "Lihat Lowongan",
                onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webCheckJobs,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          widget: 'button',
                          screen: 'talent pool')));
                  KukerjaEnv.launchKukerjaAppLink();
                },
              )
              // InkWell(
              //   child: Image.asset(
              //     'assets/images/google-play.png',
              //     width: 150,
              //     height: 60,
              //     fit: BoxFit.fill,
              //   ),
              //   onTap: () {
              //     PostActivityUseCase.exec(ActivityRequest(
              //         type: ActivityTypeUtil.webGooglePlay,
              //         extra: ActivityExtraRequest(
              //             state: 'tap',
              //             widget: 'image',
              //             screen: 'talent pool')));
              //     KukerjaEnv.launchKukerjaAppLink();
              //   },
              // ),
              // InkWell(
              //   child: Image.asset(
              //     'assets/images/app-store.png',
              //     width: 150,
              //     height: 50,
              //     fit: BoxFit.fill,
              //   ),
              //   onTap: () {
              //     PostActivityUseCase.exec(ActivityRequest(
              //         type: ActivityTypeUtil.webAppStore,
              //         extra: ActivityExtraRequest(
              //             state: 'tap', widget: 'footer', screen: 'home')));
              //   },
              // )
            ],
          )
        ],
      ),
    );
  }
}
