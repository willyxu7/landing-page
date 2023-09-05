import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/referral_widget.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../core/config/size_config.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/nav_bar_drawer.dart';
import '../../../landing_page/style/app_color.dart';
import '../providers/applicant_provider.dart';
import '../widgets/applicants/applicant_widget.dart';

class ApplicantScreen extends StatefulWidget {
  static const String route = '/applicants';

  const ApplicantScreen({Key? key})
      : super(key: key);

  @override
  State<ApplicantScreen> createState() => _ApplicantScreenState();
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  final String _id = QR.params["id"].toString();
  final String? source = QR.params["source"].toString();

  @override
  void initState() {
    // context.read<ApplicantProvider>().id = widget.id;

    PostActivityUseCase.exec(ActivityRequest(
        detail: _id,
        type: ActivityTypeUtil.webViewApplicantPage,
        extra: ActivityExtraRequest(source: source)));
    context.read<ApplicantProvider>().fetchApplicants(_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return context.watch<ApplicantProvider>().isLoading
        ? const AppLoadingWidget()
        : Scaffold(
            appBar: const NavBar(),
            drawer: const NavBarDrawer(),
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: const SingleChildScrollView(
                          child: ApplicantWidget())),
                  ReferralWidget(activityDetailId: _id,)
                ],
              ),
            ),
            floatingActionButton: context
                    .watch<ApplicantProvider>()
                    .isShowClaimBalance
                ? Container()
                : FloatingActionButton(
                    backgroundColor: AppColor.secondary,
                    onPressed: () =>
                        context.read<ApplicantProvider>().showClainBalance(),
                    child: const Icon(FontAwesomeIcons.gift)),
          );
  }
}
