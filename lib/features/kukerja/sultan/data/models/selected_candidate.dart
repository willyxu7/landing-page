import 'package:flutter/material.dart';

class SelectedCandidate {
  late String id, name, profilePhotoPath;
  DateTime? interviewDate;
  TimeOfDay? interviewTime;

  SelectedCandidate({
    required this.id,
    required this.name,
    required this.profilePhotoPath,
    required this.interviewDate,
    required this.interviewTime,
  });

  @override
  String toString() {
    return 'SelectedCandidate{id: $id, name: $name, profilePhotoPath: $profilePhotoPath, interviewDate: $interviewDate, interviewTime: $interviewTime}';
  }
}
