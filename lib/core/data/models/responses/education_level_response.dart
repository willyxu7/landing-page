class EducationLevelResponse {
  final List<String> educations;

  EducationLevelResponse({required this.educations});

  factory EducationLevelResponse.fromMap(Map<String, dynamic> response) {
    return EducationLevelResponse(educations: List<String>.from(response["data"]));
  }

}