import 'dart:convert';
import 'dart:typed_data';

import 'create_education_formal_request.dart';
import 'create_education_non_formal_request.dart';
import 'create_experience_request.dart';

class CreateTalentPoolCVRequest {
  late Uint8List? pasPhoto;

  late String type,
      name,
      email,
      phoneNumber,
      gender,
      married,
      religion,
      city,
      industry;

  late DateTime birthDate;

  late String? companyName, position, startYear;

  late List<CreateEducationFormalRequest>? createEducationFormalRequests;
  late List<CreateEducationNonFormalRequest>? createEducationNonFormalRequests;
  late List<CreateExperienceRequest>? createExperienceRequests;

  CreateTalentPoolCVRequest(
      {required this.pasPhoto,
      required this.type,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.married,
      required this.religion,
      required this.birthDate,
      required this.city,
      required this.industry,
      this.createEducationFormalRequests,
      this.createEducationNonFormalRequests,
      this.createExperienceRequests,
      this.companyName,
      this.position,
      this.startYear});

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": pasPhoto != null ? base64.encode(pasPhoto!) : "",
      "type": type,
      "name": name,
      "email": email,
      "phonenumber": phoneNumber,
      "gender": gender,
      "status": married,
      "religion": religion,
      "birthDate": birthDate.toIso8601String(),
      "city": city,
      "industry": industry,
      "education": concatEducation(),
      "experience": createExperienceRequests!
          .map((experience) => experience.toMap())
          .toList(),
      "currentJob": mapCurrentJob()
    };
  }

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
    return 'CreateTalentPoolCVRequest{name: $name, phoneNumber: $phoneNumber, gender: $gender, married: $married, religion: $religion, birthDate: $birthDate, city: $city, industry: $industry, companyName: $companyName, position: $position, startYear: $startYear, createEducationFormalRequests: $createEducationFormalRequests, createEducationNonFormalRequests: $createEducationNonFormalRequests, createExperienceRequests: $createExperienceRequests}';
  }
}
