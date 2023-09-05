import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';

import 'items/recommendation_desktop_widget.dart';
import 'items/recommendation_mobile_widget.dart';

class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ResponsiveWidget.isSmallScreen(context)
          ? const RecommendationMobileWidget()
          : const RecommendationDesktopWidget(),
    );
  }
}
