import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/recommendation_response.dart';

abstract class RecommendationRepository {
  Future<List<RecommendationResponse>> fetchRecommendation(String employerId);
}