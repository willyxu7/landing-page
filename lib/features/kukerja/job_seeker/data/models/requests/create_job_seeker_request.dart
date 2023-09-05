import 'dart:convert';
import 'dart:typed_data';

import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_experience_request.dart';

class CreateJobSeekerRequest {
  late Uint8List? pasPhoto;

  late String type, name, email, gender, married, religion, city, industry, phoneNumber;

  late DateTime birthDate;

  late List<CreateEducationFormalRequest>? createEducationFormalRequests;
  late List<CreateEducationNonFormalRequest>? createEducationNonFormalRequests;
  late List<CreateExperienceRequest>? createExperienceRequests;

  late String? companyName, position, startYear;

  CreateJobSeekerRequest({required this.pasPhoto,
    required this.type,
    required this.name,
    required this.email,
    required this.gender,
    required this.married,
    required this.religion,
    required this.city,
    required this.industry,
    required this.birthDate,
    required this.phoneNumber,
    this.createEducationFormalRequests,
    this.createEducationNonFormalRequests,
    this.createExperienceRequests,
    this.companyName,
    this.position,
    this.startYear});

  Map<String, dynamic> toMap() =>
      {
        "imageUrl": pasPhoto != null ? base64.encode(pasPhoto!) : "",
        "type": type,
        "name": name,
        "email": email,
        "gender": gender,
        "status": married,
        "religion": religion,
        "birthDate": birthDate.toIso8601String(),
        "city": city,
        "industry": industry,
        "phonenumber": phoneNumber,
        "education": concatEducation(),
        "experience": createExperienceRequests!
            .map((experience) => experience.toMap())
            .toList(),
        "currentJob": mapCurrentJob()
      };

  String toJson() => jsonEncode(toMap());

  List<Map> concatEducation() {
    List<Map> educations = [];

    for (var educationFormal in createEducationFormalRequests!) {
      educations.add(educationFormal.toMap());
    }

    for (var educationNonFormal in createEducationNonFormalRequests!) {
      educations.add(educationNonFormal.toMap());
    }

    return educations;
  }

  Map<String, dynamic> mapCurrentJob() =>
      {"companyName": companyName, "position": position, "start": startYear};

  @override
  String toString() {
    return 'CreateJobSeekerRequest{pasPhoto: $pasPhoto, type: $type, name: $name, email: $email, gender: $gender, married: $married, religion: $religion, city: $city, industry: $industry, birthDate: $birthDate, createEducationFormalRequests: $createEducationFormalRequests, createEducationNonFormalRequests: $createEducationNonFormalRequests, createExperienceRequests: $createExperienceRequests, companyName: $companyName, position: $position, startYear: $startYear}';
  }
}
