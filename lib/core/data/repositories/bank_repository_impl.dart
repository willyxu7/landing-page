import 'package:kukerja_web/core/data/models/responses/bank_response.dart';
import 'package:kukerja_web/core/domain/repositories/bank_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class BankRepositoryImpl extends BankRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<BankResponse> fetchBanks() async {
    try {
      var response = await _apiHelper.get("/management/resources/bank");

      return BankResponse.fromMap(response);
    } on AppException catch(_) {
      rethrow;
    }
  }

}