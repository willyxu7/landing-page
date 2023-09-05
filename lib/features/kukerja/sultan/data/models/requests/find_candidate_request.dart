import 'dart:convert';

class FindCandidateRequest {
  String city;
  String? experience, gender, age;
  List<String>? educationLevels;

  FindCandidateRequest(
      {required this.educationLevels,
      required this.city,
      this.experience,
      this.gender,
      this.age});

  Map<String, dynamic> toMap() => {
        "experience": experience,
        "education_level": educationLevels,
        "gender": gender == "Pria & Wanita" ? null : gender,
        "age": age,
        "city": city
      };

  String toJson() => jsonEncode(toMap());
}
