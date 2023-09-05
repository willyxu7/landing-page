import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'job_seeker_cv_attachment_widget.dart';


class JobSeekerCvEducationWidget extends StatelessWidget {
  const JobSeekerCvEducationWidget({Key? key}) : super(key: key);

  Widget getAttachmentContent(
      String startYear, String lastYear, String description) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(FontAwesomeIcons.university))),
          Expanded(
            flex: 1,
            child: Text('$startYear - $lastYear'),
          ),
          Expanded(
            flex: 8,
            child: Text(
              description,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> renderAttachmentContents() {
    List<Widget> attachmentContents = [];

    for (int i = 0; i < 3; i++) {
      attachmentContents.add(getAttachmentContent(
          '2014', '2019', 'Politekkes kemenkes pontianak'));
    }

    return attachmentContents;
  }

  @override
  Widget build(BuildContext context) {
    return JobSeekerCvAttachmentWidget(
      attachmentTitle: 'Pendidikan',
      attachmentContents: renderAttachmentContents(),
    );
  }
}
