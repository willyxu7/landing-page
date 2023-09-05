class EducationResponse {
  final List<String> smk;
  final List<String> studyPrograms;
  final List<String> courses;

  EducationResponse(
      {required this.smk, required this.studyPrograms, required this.courses});

  factory EducationResponse.fromMap(Map<String, dynamic> response) {
    return EducationResponse(
        smk: List<String>.from(response["list"]["SMK"]),
        studyPrograms: List<String>.from(response["list"]["PROGRAMSTUDI"]),
        courses: List<String>.from(response["list"]["KURSUS"]));
  }
}
