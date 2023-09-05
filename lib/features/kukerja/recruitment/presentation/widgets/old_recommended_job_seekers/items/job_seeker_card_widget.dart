import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';

class JobSeekerCardWidget extends StatelessWidget {
  final int index;
  int activeIndex;
  final String profilePhotoPath;
  final String name;
  final String description;

  JobSeekerCardWidget({
    required this.index,
    required this.activeIndex,
    required this.profilePhotoPath,
    required this.name,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: index == activeIndex
                      ? AppColor.primary
                      : Colors.transparent,
                  width: 4),
              bottom: const BorderSide(color: Colors.grey, width: 1))),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(profilePhotoPath),
                    radius: 30,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
