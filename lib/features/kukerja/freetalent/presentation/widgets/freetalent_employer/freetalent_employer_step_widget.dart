import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/items/freetalent_step_desktop_widget.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/items/freetalent_step_mobile_widget.dart';

class FreetalentEmployerStepWidget extends StatelessWidget {
  const FreetalentEmployerStepWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? const FreetalentStepMobileWidget()
        : const FreetalentStepDesktopWidget()
    ;
  }
}
