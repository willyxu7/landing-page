import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/recommendation_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/repositories/recommendation_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/recommendation_repository.dart';

class RecommendationUseCase {
  final RecommendationRepository _recommendationRepository =
      RecommendationRepositoryImpl();

  Future<List<RecommendationResponse>> fetchRecommendation(String employerId) {
    return _recommendationRepository.fetchRecommendation(employerId);
  }
}
