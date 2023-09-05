import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';

import 'items/freetalent_worries_desktop_widget.dart';
import 'items/freetalent_worries_mobile_widget.dart';


class FreetalentEmployerWorriesWidget extends StatelessWidget {
  const FreetalentEmployerWorriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const FreetalentWorriesMobileWidget()
        : const FreetalentWorriesDesktopWidget()
    ;
  }
}
