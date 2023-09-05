import 'package:kukerja_web/core/domain/repositories/city_repository.dart';

import '../../data/models/responses/city_response.dart';

class CityUseCase {

  final CityRepository _cityRepository;

  CityUseCase(this._cityRepository);

  Future<List<CityResponse>> fetchCities() {
    return _cityRepository.fetchCities();
  }

}