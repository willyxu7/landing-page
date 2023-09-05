import 'package:flutter/material.dart';

class RegionContent extends StatelessWidget {
  final String title;
  final List<String> contents;

  const RegionContent({
    Key? key,
    required this.title,
    required this.contents,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Widget> contentWidgets = [
      Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
      ),
      const SizedBox(height: 20),
    ];
    contents.asMap().forEach((index, content) {
      contentWidgets.add(Text(content));

      if (index != contents.last) {
        contentWidgets.add(const SizedBox(height: 20));
      }
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contentWidgets),
    );
  }
}
