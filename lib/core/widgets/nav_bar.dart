import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';
import '../config/responsive.dart';
import '../config/size_config.dart';
import 'nav_bar_content.dart';

class NavBar extends StatelessWidget implements PreferredSize {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        // iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.menu),
            color: AppColor.primary,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     child: Container(
        //       width: 60.0,
        //       color: Colors.white,
        //       padding: const EdgeInsets.all(10),
        //       child: SvgPicture.asset(
        //         'assets/svg/fi-rr-search.svg',
        //         color: AppColor.primary,
        //         fit: BoxFit.scaleDown,
        //       ),
        //     ),
        //     onTap: () => print('object'),
        //   ),
        // ],
        title: InkWell(
          child: Image.asset(
            'assets/images/kukerja_logo.png',
            fit: BoxFit.cover,
            width: 125,
          ),
          onTap: () => QR.to('/'),
        )
    )
        : ResponsiveWidget.isMediumScreen(context)
        ? AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        // iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     child: Container(
        //       width: 60.0,
        //       color: Colors.white,
        //       padding: const EdgeInsets.all(10),
        //       child: SvgPicture.asset(
        //         'assets/svg/fi-rr-search.svg',
        //         color: AppColor.primary,
        //         fit: BoxFit.scaleDown,
        //       ),
        //     ),
        //     onTap: () => print('object'),
        //   ),
        // ],
        title: InkWell(
          child: Image.asset(
            'assets/images/kukerja_logo.png',
            fit: BoxFit.cover,
            width: 125,
          ),
          onTap: () => QR.to('/'),
        )
    )
        : PreferredSize(
      preferredSize: Size(SizeConfig.screenWidth, 1000),
      child: const NavBarContent(),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
