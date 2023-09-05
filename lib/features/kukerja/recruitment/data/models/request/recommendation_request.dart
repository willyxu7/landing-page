import 'dart:convert';

class RecommendationRequest {
  String age, gender, experience, city;
  Map educationLevels;

  RecommendationRequest({
    required this.age,
    required this.city,
    required this.educationLevels,
    required this.experience,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'educationLevels': educationLevels,
      'gender': gender,
      'age': age,
      'experience': experience,
      'city': city
    };
  }

  String toJson() => jsonEncode(toMap());
}
