import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/old_recommended_job_seekers/items/job_seeker_cv_widget.dart';

@Deprecated('Untuk sementara ini tidak digunakan karena '
    'akan dibuat Recommended Job Seeker yang baru')
class JobSeekerCvScreen extends StatelessWidget {
  const JobSeekerCvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: JobSeekerCvWidget(),
    );
  }
}
