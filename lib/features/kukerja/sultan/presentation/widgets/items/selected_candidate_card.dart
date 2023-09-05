import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';

class SelectedCandidateCard extends StatelessWidget {
  final String id, name, profilePhotoPath, interviewDate, interviewTime;
  final Function(String) onRemoved;
  final Function() onTap;

  const SelectedCandidateCard({
    required this.id,
    required this.name,
    required this.profilePhotoPath,
    required this.interviewDate,
    required this.interviewTime,
    required this.onRemoved,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            child: InkWell(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 120,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          minRadius: 32,
                          maxRadius: 32,
                          backgroundImage:
                              CachedNetworkImageProvider(profilePhotoPath),
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        interviewDate,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        "Pukul $interviewTime",
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  )),
              onTap: () {
                onTap();
              },
            )),
        Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: null,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(FontAwesomeIcons.solidCircleXmark,
                  color: AppColor.primary),
              onPressed: () {
                onRemoved(id);
              },
            ))
      ],
    );
  }
}
