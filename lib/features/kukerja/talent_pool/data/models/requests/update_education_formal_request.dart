import 'dart:typed_data';

class UpdateEducationFormalRequest {
  late String educationLevel;
  late String educationPlace;
  late String? studyProgram;
  late String? educationExperience;
  late bool isStillStudying;
  late String startYear;
  late String? endYear;
  late Uint8List? certificate;

  UpdateEducationFormalRequest(
      {required this.educationLevel,
      required this.educationPlace,
      this.studyProgram,
      this.educationExperience,
      required this.isStillStudying,
      required this.startYear,
      this.endYear,
      this.certificate});

}
