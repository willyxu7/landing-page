import 'package:flutter/material.dart';
import '../../../../../../core/config/responsive.dart';
import 'home_banner_desktop.dart';
import 'home_banner_mobile.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(children: [
      Container(
        height: screenSize.height,
        decoration: const BoxDecoration(
          color: Color(0XFFdc143c),
        ),
        margin: const EdgeInsets.only(bottom: 120.0),
      ),
      ResponsiveWidget.isSmallScreen(context)
          ? const HomeBannerMobile()
          : ResponsiveWidget.isMediumScreen(context)
              ? const HomeBannerMobile()
              : const HomeBannerDesktop()
    ]);
  }
}
