import 'dart:convert';

import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employee_response.dart';

class RecommendationResponse {
  late ProfileEmployeeResponse? profileEmployee;

  RecommendationResponse({this.profileEmployee});

  factory RecommendationResponse.fromMap(
      Map<String, dynamic> responseData) {
    return RecommendationResponse(
        profileEmployee: ProfileEmployeeResponse.fromMap(responseData));
  }

  factory RecommendationResponse.fromJson(String source) =>
      RecommendationResponse.fromMap(json.decode(source));

  static List<RecommendationResponse> listFromMap(
      List<dynamic> employees) {
    List<RecommendationResponse> recommendedJobSeekerResponses = [];

    for (var employee in employees) {
      recommendedJobSeekerResponses
          .add(RecommendationResponse.fromMap(employee));
    }

    return recommendedJobSeekerResponses;
  }
}
