import 'dart:typed_data';

class UpdateEducationNonFormalRequest {
  late String educationPlace;
  late String course;
  late String? educationExperience;
  late bool isStillStudying;
  late String startYear;
  late String? endYear;
  late Uint8List? certificate;

  UpdateEducationNonFormalRequest(
      {required this.educationPlace,
        required this.course,
        this.educationExperience,
        required this.isStillStudying,
        required this.startYear,
        this.endYear,
        this.certificate});

  @override
  String toString() {
    return 'UpdateEducationNonFormalRequest{educationPlace: $educationPlace, course: $course, educationExperience: $educationExperience, isStillStudying: $isStillStudying, startYear: $startYear, endYear: $endYear, certificate: $certificate}';
  }
}
