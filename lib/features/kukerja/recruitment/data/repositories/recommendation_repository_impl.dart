import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/recommendation_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/recommendation_repository.dart';

class RecommendationRepositoryImpl
    implements RecommendationRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<List<RecommendationResponse>> fetchRecommendation(
      String employerId) async {
    try {
      var responseJson =
          await _apiHelper.get('/management/users/recommendation/$employerId');
      List responseData = responseJson['data'];

      return RecommendationResponse.listFromMap(responseData);
    } on AppException catch (_) {
      rethrow;
    }
  }
}
