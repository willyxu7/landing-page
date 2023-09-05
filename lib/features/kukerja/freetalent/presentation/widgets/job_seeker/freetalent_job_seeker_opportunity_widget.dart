import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';

import 'items/freetalent_opportunity_desktop_widget.dart';
import 'items/freetalent_opportunity_mobile_widget.dart';

class FreetalentJobSeekerOpportunityWidget extends StatelessWidget {
  const FreetalentJobSeekerOpportunityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const FreetalentOpportunityMobileWidget()
        : const FreetalentOpportunityDesktopWidget();
  }
}
