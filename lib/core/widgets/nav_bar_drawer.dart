import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/data/datasources/local_data/feature_local_data.dart';
import 'package:kukerja_web/core/data/repositories/feature_menu_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/feature_menu.dart';
import 'package:kukerja_web/core/domain/usecases/feature_menu_usecase.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'dart:html' as html;

class NavBarDrawer extends StatefulWidget {
  const NavBarDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreDrawerState createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<NavBarDrawer> {
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
    SizeConfig().init(context);

    return Drawer(
      child: Container(
        color: AppColor.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: LocalStorageUtil.readUserName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    Widget profile;
                    if (snapshot.hasData) {
                      profile = Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.secondary,
                            foregroundColor: Colors.white,
                            radius: 16,
                            child: Text(snapshot.data!.substring(0, 1)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            snapshot.data!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      );
                    } else {
                      profile = Image.asset(
                        'assets/images/kukerja_logo_bw.png',
                        width: 120,
                      );
                    }
                    return profile;
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () => QR.to('/'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(FontAwesomeIcons.house,
                            color: Colors.white, size: 22),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.diagramProject,
                            color: Colors.white, size: 22),
                        const SizedBox(
                          width: 20,
                        ),
                        PopupMenuButton(
                          color: AppColor.primary,
                          itemBuilder: (context) {
                            List<PopupMenuEntry> items = [];

                            items.add(const PopupMenuItem(
                              value: "",
                              child: Text(
                                "Fitur",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ));
                            for (var featureMenu in featureMenus) {
                              items.add(PopupMenuItem(
                                  onTap: () => QR.to(featureMenu.route),
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          featureMenu.icon,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          featureMenu.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        )
                                      ])));
                            }
                            return items;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Fitur",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(width: 120),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  FontAwesomeIcons.angleDown,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      QR.to('/tickets');
                      PostActivityUseCase.exec(ActivityRequest(
                          type: ActivityTypeUtil.webHomeBuyTicket,
                          extra: ActivityExtraRequest(
                              state: 'tap',
                              widget: 'mobile navigation bar',
                              screen: 'home')));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(FontAwesomeIcons.university,
                            color: Colors.white, size: 22),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Kukerjakademy',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: LocalStorageUtil.readUserName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    Widget buttonAction;
                    if (snapshot.hasData) {
                      buttonAction = Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () async {
                              await LocalStorageUtil.deleteAll();
                              html.window.location.replace("/sign-in");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(FontAwesomeIcons.arrowRightFromBracket,
                                    color: Colors.white, size: 22),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            )),
                      );
                    } else {
                      buttonAction = Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () => QR.to('/sign-in'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(FontAwesomeIcons.arrowRightFromBracket,
                                    color: Colors.white, size: 22),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            )),
                      );
                    }
                    return buttonAction;
                  }),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      children: [
                        TextSpan(text: 'Copyrights © All Rights Reserved By '),
                        TextSpan(
                            text: 'PT Sinergi Kukerja Indonesia',
                            style: TextStyle(color: Colors.amber))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
