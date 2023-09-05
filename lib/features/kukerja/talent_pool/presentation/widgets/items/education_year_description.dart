import 'package:flutter/material.dart';

class EducationYearDescription extends StatelessWidget {
  final String title;
  final String start;
  final String end;

  const EducationYearDescription({
    required this.title,
    required this.start,
    required this.end,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
          Text("$start - $end")
        ],
      ),
    );
  }
}
