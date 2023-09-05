import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/data/models/responses/profession_response.dart';

abstract class ProfessionRepository {
  Future<ProfessionResponse> fetchProfessions();

  Future<List<ProfessionDataResponse>> fetchDataProfessions();
}