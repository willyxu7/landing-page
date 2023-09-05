import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/job_provider.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/jobs/job_details_widget.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../core/config/size_config.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/nav_bar_drawer.dart';
import '../../../landing_page/style/app_color.dart';

class JobDetailsScreen extends StatefulWidget {
  static const String route = '/jobs';

  const JobDetailsScreen({Key? key})
      : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final String _id = QR.params["id"].toString();
  final String? source = QR.params["source"].toString();

  late JobProvider _jobProvider;
  @override
  void initState() {
    _jobProvider = context.read<JobProvider>();
    _jobProvider.id = _id;

    PostActivityUseCase.exec(ActivityRequest(
        detail: _id,
        type: ActivityTypeUtil.webViewJobDetails,
        extra: ActivityExtraRequest(source: source)));
    _jobProvider.fetchJobDetails(_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _jobProvider = context.watch<JobProvider>();

    return _jobProvider.isLoading
        ? const Center(
            child: SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                color: AppColor.primary,
                backgroundColor: Colors.grey,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColor.primary,
            appBar: const NavBar(),
            drawer: const NavBarDrawer(),
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: const SingleChildScrollView(
                          child: JobDetailsWidget())),
                ],
              ),
            ),
          );
  }
}
