import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';

import '../widgets/old_recommended_job_seekers/old_recommended_job_seeker_widget.dart';


@Deprecated('Untuk sementara ini tidak digunakan karena '
    'akan dibuat Recommended Job Seeker yang baru')
class OldRecommendedJobSeekerScreen extends StatefulWidget {
  static const String route = '/old-recommended-job-seekers';

  const OldRecommendedJobSeekerScreen({Key? key}) : super(key: key);

  @override
  _OldRecommendedJobSeekerScreenState createState() =>
      _OldRecommendedJobSeekerScreenState();
}

class _OldRecommendedJobSeekerScreenState
    extends State<OldRecommendedJobSeekerScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      appBar: NavBar(),
      drawer: NavBarDrawer(),
      body: SafeArea(
        child: Center(
          child: OldRecommendedJobSeekerWidget(),
        ),
      ),
    );
  }
}
