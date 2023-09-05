import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/contact_us_floating_button.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/core/domain/entities/api_status.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/talent_pool_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../env/kukerja_env.dart';
import '../../../activity/data/models/requests/activity_extra_request.dart';

class TalentPoolScreen extends StatefulWidget {
  static const String route = "/talent-pools";

  const TalentPoolScreen({Key? key}) : super(key: key);

  @override
  State<TalentPoolScreen> createState() => _TalentPoolScreenState();
}

class _TalentPoolScreenState extends State<TalentPoolScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TalentPoolProvider>().initData();
  }

  Widget _initWidget(BuildContext context) {
    late Widget readyWidget;

    APIResponse apiResponse = context.watch<TalentPoolProvider>().apiResponse;

    if (apiResponse.status == APIStatus.completed) {
      readyWidget = Center(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 36),
            child: Column(
              children: const [
                // SmallButton(text: "Next", onPressed: () {
                //   context.read<TalentPoolProvider>().pageController.nextPage(
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.easeIn);
                // }),
                Expanded(child: TalentPoolWidget())
              ],
            )),
      );
    } else if (apiResponse.status == APIStatus.loading) {
      readyWidget = const AppLoadingWidget();
    } else {
      readyWidget = Center(child: Text(apiResponse.message!));
    }

    return readyWidget;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavBarDrawer(),
      body: SafeArea(
        child: _initWidget(context),
      ),
      floatingActionButton: ContactUsFloatingButton(
          label: const Text("Hubungi Admin Kami"),
          onPressed: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webChatWa,
                extra: ActivityExtraRequest(
                    state: 'tap',
                    widget: 'floating button',
                    screen: 'talent pool')));
            KukerjaEnv.launchKukerjaContactUsLink();
          }),
    );
  }
}
