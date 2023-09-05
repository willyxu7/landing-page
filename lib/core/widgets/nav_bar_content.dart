import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/data/datasources/local_data/feature_local_data.dart';
import 'package:kukerja_web/core/data/repositories/feature_menu_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/feature_menu.dart';
import 'package:kukerja_web/core/domain/usecases/feature_menu_usecase.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/core/widgets/primary_button.dart';
import 'package:kukerja_web/core/widgets/primary_text_button.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'dart:html' as html;

class NavBarItem extends StatelessWidget {
  final String title;
  final Function() onTap;

  const NavBarItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
        child: Text(
          title,
          style: const TextStyle(color: AppColor.primary, fontSize: 14),
        ),
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final String iconLocation;

  const NavBarIcon({Key? key, required this.iconLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: 15.0,
      margin: EdgeInsets.symmetric(horizontal: screenSize.width / 80),
      child: InkWell(
        child: SvgPicture.asset(iconLocation, color: AppColor.primary),
      ),
    );
  }
}

class NavBarContent extends StatefulWidget {
  const NavBarContent({Key? key}) : super(key: key);

  @override
  _NavBarContentState createState() => _NavBarContentState();
}

class _NavBarContentState extends State<NavBarContent> {
  final FeatureMenuUseCase _featureMenuUseCase =
      FeatureMenuUseCase(FeatureMenuRepositoryImpl(FeatureLocalData()));

  List<FeatureMenu> featureMenus = [];

  @override
  void initState() {
    super.initState();
    featureMenus = _featureMenuUseCase.getFeatureMenus();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(SizeConfig.screenWidth, 1000),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 5,
          )
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 10, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Image.asset('assets/images/kukerja_logo.png',
                    fit: BoxFit.fitWidth, width: 120),
                onTap: () => QR.to('/'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 20),
                    NavBarItem(
                      title: 'Home',
                      onTap: () => QR.to('/'),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        List<PopupMenuEntry> items = [];

                        items.add(const PopupMenuItem(
                          value: "",
                          child: Text(
                            "Fitur",
                            style: TextStyle(
                                color: AppColor.primary, fontSize: 14),
                          ),
                        ));
                        for (var featureMenu in featureMenus) {
                          items.add(PopupMenuItem(
                              onTap: () => QR.to(featureMenu.route),
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      featureMenu.icon,
                                      size: 14,
                                      color: AppColor.primary,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      featureMenu.title,
                                      style: const TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 14),
                                    )
                                  ])));
                        }
                        return items;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width / 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Fitur",
                              style: TextStyle(
                                  color: AppColor.primary, fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              FontAwesomeIcons.angleDown,
                              size: 14,
                              color: AppColor.primary,
                            )
                          ],
                        ),
                      ),
                    ),
                    // const AppbarItem(title: 'Kukerjakademy'),
                    NavBarItem(
                      title: 'Kukerjakademy',
                      onTap: () {
                        QR.to('/tickets');
                        PostActivityUseCase.exec(ActivityRequest(
                            type: ActivityTypeUtil.webHomeBuyTicket,
                            extra: ActivityExtraRequest(
                                state: 'tap',
                                widget: 'desktop navigation bar',
                                screen: 'home')));
                      },
                    ),
                  ],
                ),
              ),
              // const AppbarIcon(iconLocation: 'assets/svg/fi-rr-search.svg'),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      PrimaryButton(
                        text: "Coba Gratis",
                        onPressed: () => KukerjaEnv.launchKukerjaAppLink(),
                        fontSize: 14,
                      ),
                      const SizedBox(width: 16),
                      FutureBuilder<String?>(
                          future: LocalStorageUtil.readUserName(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            Widget buttonAction;
                            if (snapshot.hasData) {
                              buttonAction = PopupMenuButton(
                                itemBuilder: (context) {
                                  List<PopupMenuEntry> items = [];

                                  items.add(PopupMenuItem(
                                      value: "",
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColor.secondary,
                                            foregroundColor: Colors.white,
                                            radius: 16,
                                            child: Text(
                                                snapshot.data!.substring(0, 1)),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            snapshot.data!,
                                            style: const TextStyle(
                                                color: AppColor.primary,
                                                fontSize: 14),
                                          ),
                                        ],
                                      )));
                                  items.add(const PopupMenuDivider());
                                  items.add(
                                    PopupMenuItem(
                                        onTap: () async {
                                          await LocalStorageUtil.deleteAll();
                                          html.window.location.replace("/sign-in");
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .arrowRightFromBracket,
                                                    size: 14,
                                                    color: AppColor.primary,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Sign Out",
                                                    style: TextStyle(
                                                        color: AppColor.primary,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                  return items;
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.secondary,
                                      foregroundColor: Colors.white,
                                      radius: 16,
                                      child:
                                          Text(snapshot.data!.substring(0, 1)),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      snapshot.data!,
                                      style: const TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      FontAwesomeIcons.angleDown,
                                      size: 14,
                                      color: AppColor.primary,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              buttonAction = PrimaryTextButton(
                                text: "Sign In",
                                onPressed: () => QR.to("/sign-in"),
                                fontSize: 14,
                              );
                            }
                            return buttonAction;
                          }),
                    ],
                  )),
              SizedBox(
                width: screenSize.width / 80,
              ),
              // InkWell(
              //     child: Image.asset(
              //         '/images/play_store.png',
              //       fit: BoxFit.fitWidth,
              //       width: 120
              //     )
              // ),
              // SizedBox(
              //   width: screenSize.width / 200,
              // ),
              // InkWell(
              //     child: Image.asset(
              //         '/images/play_store.png',
              //       fit: BoxFit.fitWidth,
              //       width: 120
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
