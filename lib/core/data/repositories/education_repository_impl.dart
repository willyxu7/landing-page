import 'package:kukerja_web/core/domain/repositories/education_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

import '../models/responses/education_response.dart';

class EducationRepositoryImpl extends EducationRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<EducationResponse> fetchEducations() async {
    try {
      var response = await _apiHelper.get("/management/resources/educations");

      return EducationResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }

}