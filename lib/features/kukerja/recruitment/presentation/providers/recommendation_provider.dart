import 'package:flutter/cupertino.dart';
import 'package:kukerja_web/core/exceptions/bad_request_exception.dart';
import 'package:kukerja_web/core/exceptions/fetch_data_exception.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/recommendation_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/usecases/recommendation_use_case.dart';

import '../../../../../core/domain/entities/api_status.dart';

class RecommendationProvider with ChangeNotifier {
  late String _employerId;
  bool _isLoading = true;
  final APIResponse _apiResponse = APIResponse(APIStatus.loading);
  late List<RecommendationResponse> _recommendationResponses;
  final RecommendationUseCase _recommendedJobSeekerUseCase =
      RecommendationUseCase();

  get isLoading => _isLoading;

  get recommendedJobSeekerResponse => _recommendationResponses;

  get apiResponse => _apiResponse;

  get employerId => _employerId;

  void setEmployerId(String employerId) {
    _employerId = employerId;
  }

  void setNotLoading() {
    _isLoading = false;
  }

  Future<void> fetchRecommendation(String employerId) async {
    try {
      _recommendationResponses =
          await _recommendedJobSeekerUseCase.fetchRecommendation(employerId);
      _apiResponse.setCompleted();
    } catch (e) {
      if (e is BadRequestException) {
        _apiResponse.setError('Fetch data gagal');
      } else if (e is FetchDataException) {
        _apiResponse.setError('Terjadi masalah di server');
      }
    }
    notifyListeners();
  }
}
