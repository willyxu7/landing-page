import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/jobs/items/job_details_desktop_widget.dart';

class JobDetailsWidget extends StatelessWidget {
  const JobDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: MOBILE RESPONSIVE
    return const Center(
      child: JobDetailsDesktopWidget(),
    );
  }
}
