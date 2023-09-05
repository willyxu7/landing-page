import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/recommendation_provider.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../core/utils/activity_type_util.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/referral_widget.dart';
import '../../../activity/data/models/requests/activity_request.dart';
import '../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../landing_page/style/app_color.dart';
import '../../../../../core/domain/entities/api_status.dart';
import '../providers/applicant_provider.dart';
import '../widgets/recommendations/recommendation_widget.dart';

class RecommendationScreen extends StatefulWidget {
  static const String route = '/recommendations';

  const RecommendationScreen({Key? key})
      : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final String _employerId = QR.params["employerId"].toString();

  @override
  void initState() {
    super.initState();

    context.read<RecommendationProvider>().setEmployerId(_employerId);

    PostActivityUseCase.exec(ActivityRequest(
        detail: _employerId,
        type: ActivityTypeUtil.webViewRecommendedJobSeekers,
        extra: ActivityExtraRequest(
          screen: "recommended job seeker",
        )));

    context
        .read<RecommendationProvider>()
        .fetchRecommendation(_employerId);
  }

  Widget _renderWidget(BuildContext context) {
    late Widget newWidget;

    APIResponse apiResponse =
        context.watch<RecommendationProvider>().apiResponse;
    if (apiResponse.status == APIStatus.completed) {
      newWidget = Stack(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: const SingleChildScrollView(child: RecommendationWidget()),
          ),
          ReferralWidget(activityDetailId: _employerId,)
        ],
      );
    } else if (apiResponse.status == APIStatus.loading) {
      newWidget = const AppLoadingWidget();
    } else {
      newWidget = Center(child: Text(apiResponse.message!));
    }

    return newWidget;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavBarDrawer(),
      body: SafeArea(
        child: _renderWidget(context),
      ),
      floatingActionButton:
          context.watch<ApplicantProvider>().isShowClaimBalance
              ? Container()
              : FloatingActionButton(
                  backgroundColor: AppColor.secondary,
                  onPressed: () =>
                      context.read<ApplicantProvider>().showClainBalance(),
                  child: const Icon(FontAwesomeIcons.gift)),
    );
  }
}
