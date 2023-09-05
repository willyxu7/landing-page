import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:provider/provider.dart';

import '../../env/kukerja_env.dart';
import '../../features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import '../../features/kukerja/activity/data/models/requests/activity_request.dart';
import '../../features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import '../../features/kukerja/landing_page/style/app_color.dart';
import '../../features/kukerja/recruitment/presentation/providers/applicant_provider.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';
import '../utils/activity_type_util.dart';

class ReferralWidget extends StatelessWidget {
  /// Caution! This Widget must use inside Stack Widget
  final String activityDetailId;

  const ReferralWidget({required this.activityDetailId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String doorPrizeDescription =
        'Nikmati pengalaman rekrut mudah dalam hitungan menit dengan aplikasi Kukerja. Cukup daftar sebagai Pemberi Kerja di Kukerja untuk mendapatkan saldo Anda sebesar Rp 25.000,-';

    return context.watch<ApplicantProvider>().isShowClaimBalance
        ? Positioned(
            bottom: 0,
            width: SizeConfig.screenWidth,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: const Offset(0, 7))
                ],
                color: AppColor.mainBackground.withOpacity(1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: SizedBox(
                        width: ResponsiveWidget.isSmallScreen(context)
                            ? SizeConfig.screenWidth
                            : SizeConfig.screenWidth * 0.55,
                        child: const AutoSizeText(doorPrizeDescription,
                            minFontSize: 16, textAlign: TextAlign.center),
                      )),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context)
                        ? SizeConfig.screenWidth
                        : SizeConfig.screenWidth * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextButton(
                              onPressed: () {
                                context
                                    .read<ApplicantProvider>()
                                    .hideShowClaimBalance();
                                PostActivityUseCase.exec(ActivityRequest(
                                    detail: activityDetailId,
                                    type:
                                        ActivityTypeUtil.webDoNotClaimReferral,
                                    extra: ActivityExtraRequest(
                                        state: 'tap',
                                        widget: 'enggak dulu',
                                        screen: 'recommended job seeker')));
                              },
                              child: const Text(
                                'Nggak dulu deh!',
                                style: TextStyle(color: AppColor.secondary),
                              )),
                        ),
                        Flexible(
                            child: SmallButton(
                                text: 'Siap Gan!',
                                onPressed: () {
                                  PostActivityUseCase.exec(ActivityRequest(
                                      detail: activityDetailId,
                                      type: ActivityTypeUtil.webClaimReferral,
                                      extra: ActivityExtraRequest(
                                          state: 'tap',
                                          widget: 'siap gan',
                                          screen: 'recommended job seeker')));
                                  if (kIsWeb &&
                                      defaultTargetPlatform ==
                                          TargetPlatform.android) {
                                    KukerjaEnv.launchRecommendedAndroidLink();
                                  } else if (kIsWeb &&
                                      defaultTargetPlatform ==
                                          TargetPlatform.windows &&
                                      defaultTargetPlatform ==
                                          TargetPlatform.macOS) {
                                    KukerjaEnv.launchRecommendedWebLink();
                                  }
                                }))
                      ],
                    ),
                  )
                ],
              ),
            ))
        : Container();
  }
}
