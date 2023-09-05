import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/core/data/models/responses/city_response.dart';
import 'package:kukerja_web/core/domain/repositories/city_repository.dart';

import '../../exceptions/app_exception.dart';

class CityRepositoryImpl implements CityRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<List<CityResponse>> fetchCities() async {
    List<CityResponse> cityResponses = [];

    try {
      var response =
          await _apiHelper.get('/management/resources/cities');

      cityResponses = CityResponse.listFromMap(response['list']);
    } on AppException catch (_) {
      rethrow;
    }

    return cityResponses;
  }
}
