import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kukerja_web/core/routes/job_seeker_route.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CandidateCard extends StatelessWidget {
  final String name, profilePhotoPath, lastEducation, lastJobExperience;
  final int age;
  final Function() onTap;

  const CandidateCard({
    required this.name,
    required this.profilePhotoPath,
    required this.lastEducation,
    required this.lastJobExperience,
    required this.age,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: GestureDetector(
          onTap: () {
            QR.navigator.push(
                "${JobSeekerRoute.baseRoute}/profile-picture/${utf8.encode(profilePhotoPath)}");
          },
          child: CircleAvatar(
            minRadius: 32,
            maxRadius: 32,
            backgroundImage: CachedNetworkImageProvider(
                profilePhotoPath.isNotEmpty
                    ? profilePhotoPath
                    : "/assets/images/asset-22.png"),
          ),
        ),
        title: Text(
          "$name / $age",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pendidikan Terakhir $lastEducation",
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text("Pengalaman $lastJobExperience",
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
