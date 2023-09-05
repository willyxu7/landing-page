import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/contact_us_floating_button.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/advertisement/advertisement.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/client_list/client_list.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/consultation/consultation.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/footer.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/frequently_asked_question/frequently_asked_question.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/home_banner/home_banner.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/recruitment/recruitment.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/region/region.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/success_story/success_story.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/why_us/why_us.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../../../../env/kukerja_env.dart';
import '../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../activity/domain/usecases/post_activity_use_case.dart';
import '../widgets/footer/layout/copyright.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ActivityRequest _activityRequest = ActivityRequest(
    type: ActivityTypeUtil.webViewHomePage,
  );

  @override
  void initState() {
    PostActivityUseCase.exec(_activityRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: AppColor.mainBackground,
        // extendBodyBehindAppBar: true,

        appBar: const NavBar(),
        drawer: const NavBarDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              HomeBanner(),
              ClientList(),
              WhyUs(),
              Region(),
              SuccessStory(),
              FrequentlyAskedQuestion(),
              Recruitment(),
              Consultation(),
              Advertisement(),
              Footer(),
              CopyRight()
            ],
          ),
        ),
        floatingActionButton: ContactUsFloatingButton(
          label: const Text('Chat WA'),
          onPressed: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webChatWa,
                extra: ActivityExtraRequest(
                    state: 'tap', widget: 'floating button', screen: 'home')));
            KukerjaEnv.launchKukerjaWaLink();
          },
        ));
  }
}
