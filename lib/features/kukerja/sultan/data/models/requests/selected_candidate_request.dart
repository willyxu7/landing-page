import 'dart:convert';

import 'package:flutter/material.dart';

class SelectedCandidateRequest {
  late String userId;
  DateTime? interviewDate;
  TimeOfDay? interviewTime;

  SelectedCandidateRequest({
    required this.userId,
    required this.interviewDate,
    required this.interviewTime,
  });

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "interviewDate": DateTime(interviewDate!.year, interviewDate!.month,
                interviewDate!.day, interviewTime!.hour, interviewTime!.minute)
            .toIso8601String()
      };

  String toJson() => jsonEncode(toMap());
}
