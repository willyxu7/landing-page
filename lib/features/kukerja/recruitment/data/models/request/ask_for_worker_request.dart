import 'dart:convert';

class AskForWorkerRequest {
  late final String employerName;
  late final String jobTitle;
  late final String criteria;
  late final String qualification;
  late final String gender;
  late final String age;
  late final String educationQualification;
  late final String selectedLocation;

  AskForWorkerRequest(
      {required this.employerName,
      required this.jobTitle,
      required this.criteria,
      required this.qualification,
      required this.gender,
      required this.age,
      required this.educationQualification,
      required this.selectedLocation});

  Map toMap() {
    return {
      'employerName': employerName,
      'jobTitle': jobTitle,
      'criteria': criteria,
      'qualification': qualification,
      'gender': gender,
      'age': age,
      'educationQualification': educationQualification,
      'selectedLocation': selectedLocation
    };
  }

  String toJson() => jsonEncode(toMap());

}
