import 'package:flutter/material.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/providers/job_seeker_provider.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/create_job_seeker_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/domain/entities/api_status.dart';
import '../../../../../core/widgets/app_loading_widget.dart';

class CreateJobSeekerScreen extends StatefulWidget {
  static const String route = "/create";
  const CreateJobSeekerScreen({Key? key}) : super(key: key);

  @override
  State<CreateJobSeekerScreen> createState() => _CreateJobSeekerScreenState();
}

class _CreateJobSeekerScreenState extends State<CreateJobSeekerScreen> {

  @override
  void initState() {
    super.initState();

    context.read<JobSeekerProvider>().initData();
  }

  Widget _initWidget(BuildContext context) {
    late Widget readyWidget;

    APIResponse apiResponse = context.watch<JobSeekerProvider>().apiResponse;

    if (apiResponse.status == APIStatus.completed) {
      readyWidget = const CreateJobSeekerWidget();
    } else if (apiResponse.status == APIStatus.loading) {
      readyWidget = const AppLoadingWidget();
    } else {
      readyWidget = Center(child: Text(apiResponse.message!));
    }

    return readyWidget;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _initWidget(context),
      ),
    );
  }
}
