import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../env/kukerja_env.dart';
import 'job_seeker_card_widget.dart';

class JobSeekerListContainerWidget extends StatefulWidget {
  const JobSeekerListContainerWidget({Key? key}) : super(key: key);

  @override
  State<JobSeekerListContainerWidget> createState() =>
      _JobSeekerListContainerWidgetState();
}

class _JobSeekerListContainerWidgetState
    extends State<JobSeekerListContainerWidget> {
  List<Map> jobSeekers = [];
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      jobSeekers.add({
        'name': 'Willy',
        'profilePhotoPath': 'assets/images/kukerja_logo.png',
        'description': 'Bla bla bla lba lbal balb ab'
      });
    }
  }

  Widget getJobSeekerWidgets() {
    List<Widget> jobSeekerWidgets = [];

    jobSeekerWidgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '1-${jobSeekers.length} dari 17.000 job seekers',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextButton(
          child: const Text(
            'Lihat semua',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            KukerjaEnv.launchKukerjaAppLink();
          },
        )
      ],
    ));

    for (int i = 0; i < jobSeekers.length; i++) {
      jobSeekerWidgets.add(InkWell(
        onTap: () {
          setState(() {
            activeIndex = i;
            context.goNamed('job-seeker-cv');
          });
        },
        child: JobSeekerCardWidget(
          index: i,
          activeIndex: activeIndex,
          profilePhotoPath: jobSeekers[i]['profilePhotoPath'],
          name: jobSeekers[i]['name'],
          description: jobSeekers[i]['description'],
        ),
      ));
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: jobSeekerWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(child: getJobSeekerWidgets());
  }
}
