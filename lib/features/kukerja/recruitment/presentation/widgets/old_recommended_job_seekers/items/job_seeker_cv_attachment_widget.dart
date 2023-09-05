import 'package:flutter/material.dart';

class JobSeekerCvAttachmentWidget extends StatelessWidget {
  final String attachmentTitle;
  final List<Widget> attachmentContents;

  const JobSeekerCvAttachmentWidget({
    required this.attachmentTitle,
    required this.attachmentContents,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attachmentTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        for(var attachmentContent in attachmentContents) attachmentContent,
      ],
    );
  }
}
