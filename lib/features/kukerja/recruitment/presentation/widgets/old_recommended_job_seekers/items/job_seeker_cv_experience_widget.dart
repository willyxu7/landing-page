import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'job_seeker_cv_attachment_widget.dart';

class JobSeekerCvExperienceWidget extends StatelessWidget {
  const JobSeekerCvExperienceWidget({Key? key}) : super(key: key);

  Widget getAttachmentContent(
      String starYear, String tillYear, String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: [
        Flexible(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(FontAwesomeIcons.yinYang))),
        Expanded(
          flex: 1,
          child: Text('$starYear - $tillYear'),
        ),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(description)
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> renderAttachmentContents() {
    List<Widget> attachmentContents = [];

    for (int i = 0; i < 3; i++) {
      attachmentContents.add(getAttachmentContent('2014', '2019',
          'Politekkes kemenkess pontianak', 'Melakukan vaksinasi'));
    }

    return attachmentContents;
  }

  @override
  Widget build(BuildContext context) {
    return JobSeekerCvAttachmentWidget(
      attachmentTitle: 'Pengalaman',
      attachmentContents: renderAttachmentContents(),
    );
  }
}
