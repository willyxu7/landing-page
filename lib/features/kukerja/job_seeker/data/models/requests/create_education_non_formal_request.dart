import 'dart:convert';
import 'dart:typed_data';

class CreateEducationNonFormalRequest {
  late String indexWidget;
  late String educationPlace;
  late String course;
  late String? educationExperience;
  late bool isStillStudying;
  late String startYear;
  late String? endYear;
  late Uint8List? certificate;

  CreateEducationNonFormalRequest(
      {required this.indexWidget,
        required this.educationPlace,
        required this.course,
        this.educationExperience,
        required this.isStillStudying,
        required this.startYear,
        this.endYear,
        this.certificate});

  Map<String, dynamic> toMap() => {
    "image": certificate != null ? base64.encode(certificate!) : "",
    "level": "",
    "place": educationPlace,
    "prodi": course,
    "description": educationExperience,
    "isCurrentEdu": isStillStudying,
    "isCourse": true,
    "start": startYear,
    "till": endYear
  };

  @override
  String toString() {
    return 'CreateEducationNonFormalRequest{indexWidget: $indexWidget, educationPlace: $educationPlace, course: $course, educationExperience: $educationExperience, isStillStudying: $isStillStudying, startYear: $startYear, endYear: $endYear, certificate: $certificate}';
  }
}
