import 'package:flutter/material.dart';

class ExperienceDescription extends StatelessWidget {
  final String title;
  final String content;

  const ExperienceDescription({
    required this.title,
    required this.content,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
          Text(content)
        ],
      ),
    );
  }
}
