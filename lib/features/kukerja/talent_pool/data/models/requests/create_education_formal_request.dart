import 'dart:convert';
import 'dart:typed_data';

class CreateEducationFormalRequest {
  late String indexWidget;
  late String educationLevel;
  late String educationPlace;
  late String? studyProgram;
  late String? educationExperience;
  late bool isStillStudying;
  late String startYear;
  late String? endYear;
  late Uint8List? certificate;

  CreateEducationFormalRequest(
      {required this.indexWidget,
      required this.educationLevel,
      required this.educationPlace,
      this.studyProgram,
      this.educationExperience,
      required this.isStillStudying,
      required this.startYear,
      this.endYear,
      this.certificate});

  Map<String, dynamic> toMap() => {
    "image": certificate != null ? base64.encode(certificate!) : "",
    "level": educationLevel,
    "place": educationPlace,
    "prodi": studyProgram,
    "description": educationExperience,
    "isCurrentEdu": isStillStudying,
    "isCourse": false,
    "start": startYear,
    "till": endYear
  };
}
