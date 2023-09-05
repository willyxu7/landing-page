import 'package:kukerja_web/core/data/models/responses/education_level_response.dart';
import 'package:kukerja_web/core/domain/repositories/education_level_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class EducationLevelRepositoryImpl extends EducationLevelRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<EducationLevelResponse> fetchEducationLevels() async {
    try {
      var response =
          await _apiHelper.get("/management/resources/educations-level");

      return EducationLevelResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }
}
