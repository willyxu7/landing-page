import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/job_seeker/freetalent_job_seeker_banner_widget.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/footer.dart';

import '../widgets/job_seeker/freetalent_job_seeker_opportunity_widget.dart';
import '../widgets/job_seeker/freetalent_job_seeker_worries_widget.dart';

class FreetalentJobSeekerScreen extends StatefulWidget {
  static const String route = '/freetalents-js';

  const FreetalentJobSeekerScreen({Key? key}) : super(key: key);

  @override
  State<FreetalentJobSeekerScreen> createState() =>
      _FreetalentJobSeekerScreenState();
}

class _FreetalentJobSeekerScreenState extends State<FreetalentJobSeekerScreen> {

  @override
  void initState() {
    PostActivityUseCase.exec(ActivityRequest(
        type: ActivityTypeUtil.webViewFreetalentJobSeekers
    ));
    super.initState();
  }

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
                  FreetalentJobSeekerBannerWidget(),
                  FreetalentJobSeekerWorriesWidget(),
                  FreetalentJobSeekerOpportunityWidget(),
                  Footer()
                ]),
          ),
        ));
  }
}

