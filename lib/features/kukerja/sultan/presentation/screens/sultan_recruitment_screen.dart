import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';

import 'package:provider/provider.dart';

import '../../../../../core/widgets/app_loading_widget.dart';
import '../../../../../core/domain/entities/api_status.dart';
import '../providers/sultan_recruitment_provider.dart';
import '../widgets/sultan_recruitment_widget.dart';

class SultanRecruitmentScreen extends StatefulWidget {
  static const String route = "/sultan-recruitments";

  const SultanRecruitmentScreen({Key? key}) : super(key: key);

  @override
  State<SultanRecruitmentScreen> createState() =>
      _SultanRecruitmentScreenState();
}

class _SultanRecruitmentScreenState extends State<SultanRecruitmentScreen> {

  @override
  void initState() {
    super.initState();

    PostActivityUseCase.exec(
        ActivityRequest(type: ActivityTypeUtil.webSultanRecruitment));

    context.read<SultanRecruitmentProvider>().initData();
  }

  Widget _initWidget(BuildContext context) {
    late Widget readyWidget;

    APIResponse apiResponse =
        context.watch<SultanRecruitmentProvider>().apiResponse;

    if (apiResponse.status == APIStatus.completed) {
      readyWidget = Center(
        child: Container(
          margin: const EdgeInsets.only(top: 36),
          child: Column(
            children: const [
              // SmallButton(
              //     text: "Next",
              //     onPressed: () {
              //       context
              //           .read<SultanRecruitmentProvider>()
              //           .pageController
              //           .nextPage(
              //               duration: const Duration(milliseconds: 500),
              //               curve: Curves.easeIn);
              //     }),
              Expanded(child: SultanRecruitmentWidget())
            ],
          ),
        ),
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
    );
  }
}
