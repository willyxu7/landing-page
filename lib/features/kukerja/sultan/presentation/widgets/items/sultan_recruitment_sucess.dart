import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../../core/config/size_config.dart';
import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/widgets/heading_3.dart';
import '../../../../../../core/widgets/paragraph_widget.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';

class SultanRecruitmentSuccess extends StatefulWidget {
  const SultanRecruitmentSuccess({Key? key}) : super(key: key);

  @override
  State<SultanRecruitmentSuccess> createState() =>
      _SultanRecruitmentSuccessState();
}

class _SultanRecruitmentSuccessState extends State<SultanRecruitmentSuccess> {
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
            text: 'Terima kasih telah menggunakan fitur recruitment kami',
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
            'Selanjutnya, masuk untuk bisa melihat status undangan interview anda.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmallButton(
                  text: "Cek Wawancara",
                  onPressed: () {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webCheckInterview,
                        extra: ActivityExtraRequest(
                            state: 'tap',
                            widget: 'button',
                            screen: 'sultan recruitment')));
                    KukerjaEnv.launchKukerjaAppLink();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
