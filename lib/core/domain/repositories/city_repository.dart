import 'package:kukerja_web/core/data/models/responses/city_response.dart';

abstract class CityRepository {

  Future<List<CityResponse>> fetchCities();

}