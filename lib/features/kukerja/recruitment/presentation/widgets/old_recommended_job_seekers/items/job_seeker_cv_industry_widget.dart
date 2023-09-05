import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'job_seeker_cv_attachment_widget.dart';


class JobSeekerCvIndustryWidget extends StatelessWidget {
  const JobSeekerCvIndustryWidget({Key? key}) : super(key: key);

  Widget getAttachmentContent(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        Flexible(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(FontAwesomeIcons.industry))),
        Expanded(
          flex: 9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Politekkes kemenkes pontianak',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Melakukan vaksinasi')
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> renderAttachmentContents() {
    List<Widget> attachmentContents = [];

    for (int i = 0; i < 3; i++) {
      attachmentContents.add(getAttachmentContent(
          'Politekkes kemenkess pontianak', 'Melakukan vaksinasi'));
    }

    return attachmentContents;
  }

  @override
  Widget build(BuildContext context) {
    return JobSeekerCvAttachmentWidget(
      attachmentTitle: 'Tertarik pada bidang',
      attachmentContents: renderAttachmentContents(),
    );
  }
}
