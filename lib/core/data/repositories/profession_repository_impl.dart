import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/data/models/responses/profession_response.dart';
import 'package:kukerja_web/core/domain/repositories/profession_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class ProfessionRepositoryImpl extends ProfessionRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<ProfessionResponse> fetchProfessions() async {
    try {
      var response = await _apiHelper.get("/management/resources/professions");

      return ProfessionResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<ProfessionDataResponse>> fetchDataProfessions() async {
    try {
      var response = await _apiHelper.get("/management/resources/data");

      List professions = response["data"]["professions"]["data"] as List;
      professions.sort((a, b) => a["id"].compareTo(b["id"]));

      return professions
          .map((profession) => ProfessionDataResponse(
              name: profession["name"], id: profession["id"]))
          .toList();

      // return ProfessionResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }
}
