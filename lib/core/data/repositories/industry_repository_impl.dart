import 'package:kukerja_web/core/domain/repositories/industry_repository.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

import '../../exceptions/app_exception.dart';
import '../models/responses/industry_response.dart';

class IndustryRepositoryImpl extends IndustryRepository{
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<IndustryResponse> fetchIndustries() async {
    try {
      var response = await _apiHelper.get("/management/resources/industries");

      return IndustryResponse.fromMap(response);

    } on AppException catch (_) {
      rethrow;
    }

  }

}