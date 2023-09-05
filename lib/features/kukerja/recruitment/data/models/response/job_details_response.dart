import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employer_response.dart';

class JobDetailsResponse with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final int? salaryStart;
  final int? salaryEnd;
  final String? location;
  final ProfileEmployerResponse? profileEmployer;

  JobDetailsResponse({
    this.id,
    this.title,
    this.description,
    this.salaryStart,
    this.salaryEnd,
    this.location,
    this.profileEmployer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'salaryStart': salaryStart,
      'salaryEnd': salaryEnd,
      'location': location,
      'profileEmployer': profileEmployer?.toMap(),
    };
  }

  factory JobDetailsResponse.fromMap(Map<String, dynamic> map) {
    return JobDetailsResponse(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      salaryStart: map['salaryStart']?.toInt(),
      salaryEnd: map['salaryEnd']?.toInt(),
      location: map['location'],
      profileEmployer: map['employer'] != null
          ? ProfileEmployerResponse.fromMap(map['employer'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobDetailsResponse.fromJson(String source) =>
      JobDetailsResponse.fromMap(json.decode(source));
}
