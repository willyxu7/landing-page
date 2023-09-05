import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/freetalent_employer_step_widget.dart';

import '../../../../../core/config/size_config.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/nav_bar_drawer.dart';
import '../../../landing_page/presentation/widgets/footer/footer.dart';
import '../widgets/freetalent_employer/freetalent_employer_banner_widget.dart';
import '../widgets/freetalent_employer/freetalent_employer_opportunity_widget.dart';
import '../widgets/freetalent_employer/freetalent_employer_worries_widget.dart';

class FreetalentEmployerScreen extends StatefulWidget {
  static const String route = '/freetalents-emp';

  const FreetalentEmployerScreen({Key? key}) : super(key: key);

  @override
  _FreetalentEmployerScreenState createState() =>
      _FreetalentEmployerScreenState();
}

class _FreetalentEmployerScreenState extends State<FreetalentEmployerScreen> {
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  FreetalentEmployerBannerWidget(),
                  FreetalentEmployerWorriesWidget(),
                  FreetalentEmployerOpportunityWidget(),
                  FreetalentEmployerStepWidget(),
                  Footer()
                ]),
          ),
        ));
  }
}
