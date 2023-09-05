import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';

import '../widgets/sultan_banner_widget.dart';

class SultanScreen extends StatelessWidget {
  static const String route = "/sultan";

  const SultanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: const NavBar(),
        drawer: const NavBarDrawer(),
        body: SizedBox(
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: const [SultanBannerWidget()],
            ),
          ),
        ));
  }
}
