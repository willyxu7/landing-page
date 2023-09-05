import 'package:kukerja_web/core/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/utils/company_information_util.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';
import 'footer_text.dart';

class FooterMobile extends StatelessWidget {
  const FooterMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/kukerja_logo_bw.png',
                        width: SizeConfig.blockSizeHorizontal * 50,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      FooterText(
                        text:
                            'Mempermudah proses rekrutmen bagi UMKM dan pekerja di Indonesia',
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      InkWell(
                        child: Image.asset(
                          'assets/images/google-play.png',
                          width: 150,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        onTap: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webGooglePlay,
                              extra: ActivityExtraRequest(
                                  state: 'tap',
                                  widget: 'footer',
                                  screen: 'home')));
                          KukerjaEnv.launchKukerjaAppLink();
                        },
                      ),
                      InkWell(
                        child: Image.asset(
                          'assets/images/app-store.png',
                          width: 150,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                        onTap: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webAppStore,
                              extra: ActivityExtraRequest(
                                  state: 'tap',
                                  widget: 'footer',
                                  screen: 'home')));
                        },
                      )
                    ],
                  )),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FooterText(
                        text: 'PERUSAHAAN',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      FooterText(
                        text: 'Tentang Kami',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Klien Kami',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Kenapa Kami?',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Fitur',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Testimonial',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Blog',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Hiburan',
                        onTap: () {},
                      ),
                      FooterText(
                        text: 'Hubungi Kami',
                        onTap: () {},
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FooterText(
                        text: 'INFORMASI',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      FooterText(
                        text: 'Syarat & Ketentuan',
                        onTap: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webPrivacyAndPolicy,
                              extra: ActivityExtraRequest(
                                  screen: 'home',
                                  widget: 'footer',
                                  state: 'tap')));
                          QR.to('/terms-and-conditions');
                        },
                      ),
                      FooterText(
                        text: 'Kebijakan Privasi',
                        onTap: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webPrivacyAndPolicy,
                              extra: ActivityExtraRequest(
                                  screen: 'home',
                                  widget: 'footer',
                                  state: 'tap')));
                          QR.to('/privacy-and-policy');
                        },
                      ),
                      FooterText(
                        text: 'FAQ',
                        onTap: () {
                          PostActivityUseCase.exec(ActivityRequest(
                              type: ActivityTypeUtil.webFrequentlyAskedQuestion,
                              extra: ActivityExtraRequest(
                                  screen: 'home',
                                  widget: 'footer',
                                  state: 'tap')));
                          QR.to('/frequently-asked-questions');
                        },
                      ),
                      FooterText(
                        text: 'Cookies',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      FooterText(
                        text: 'SOSIAL MEDIA',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.only(right: 14.0),
                              child: Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              PostActivityUseCase.exec(ActivityRequest(
                                  type: ActivityTypeUtil.webFacebook,
                                  extra: ActivityExtraRequest(
                                      state: 'tap',
                                      widget: 'footer',
                                      screen: 'home')));
                              KukerjaEnv.launchKukerjaFbLink();
                            },
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.only(right: 14.0),
                              child: Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              PostActivityUseCase.exec(ActivityRequest(
                                  type: ActivityTypeUtil.webInstagram,
                                  extra: ActivityExtraRequest(
                                      state: 'tap',
                                      widget: 'footer',
                                      screen: 'home')));
                              KukerjaEnv.launchKukerjaIgLink();
                            },
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.only(right: 14.0),
                              child: Icon(
                                FontAwesomeIcons.youtube,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              PostActivityUseCase.exec(ActivityRequest(
                                  type: ActivityTypeUtil.webYoutube,
                                  extra: ActivityExtraRequest(
                                      state: 'tap',
                                      widget: 'footer',
                                      screen: 'home')));
                              KukerjaEnv.launchKukerjaYtLink();
                            },
                          ),
                          InkWell(
                            child: const Icon(
                              FontAwesomeIcons.telegram,
                              color: Colors.white,
                              size: 16,
                            ),
                            onTap: () {
                              PostActivityUseCase.exec(ActivityRequest(
                                  type: ActivityTypeUtil.webTelegram,
                                  extra: ActivityExtraRequest(
                                      state: 'tap',
                                      widget: 'footer',
                                      screen: 'home')));
                              // KukerjaEnv.ytLink;
                            },
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FooterText(
                        text: 'ALAMAT',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      FooterText(
                        text: CompanyInformationUtil.address,
                        onTap: () {},
                        isCanHover: false,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      FooterText(
                        text: 'SEND US FEEDBACK?',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        onTap: () {},
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
