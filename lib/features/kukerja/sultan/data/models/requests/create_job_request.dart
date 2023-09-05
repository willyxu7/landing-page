import 'dart:convert';

class CreateJobRequest {
  late String jobDescription, jobType, salary, salaryType, workingHour;

  late List<String>? educationQualifications, workingDays;

  CreateJobRequest(
      {required this.jobDescription,
      required this.jobType,
      required this.salary,
      required this.salaryType,
      this.educationQualifications,
      this.workingDays,
      required this.workingHour});

  factory CreateJobRequest.fromJson(Map<String, dynamic> parsedJson) =>
      CreateJobRequest(
        jobDescription: parsedJson["description"] ?? "",
        jobType: parsedJson["type"] ?? "",
        salary: parsedJson["salary"] ?? "",
        salaryType: parsedJson["salaryType"] ?? "",
        educationQualifications:
            List<String>.from(parsedJson["educations"] ?? ["ASD"]),
        workingDays: List<String>.from(parsedJson["workingDays"]),
        workingHour: parsedJson["workingHour"],
      );

  Map<String, dynamic> toMap() => {
        "description": jobDescription,
        "type": jobType,
        "salary": salary.replaceAll(".", ""),
        "salaryType": salaryType,
        "educations": educationQualifications,
        "workingDays": workingDays,
        "workingHour": workingHour
      };

  String toJson() => jsonEncode(toMap());
}
