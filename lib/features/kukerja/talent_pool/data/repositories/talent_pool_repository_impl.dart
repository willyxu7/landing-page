import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_contract_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_cv_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_job_criteria_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_cv_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_job_criteria_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/domain/repositories/talent_pool_repository.dart';

class TalentPoolRepositoryImpl extends TalentPoolRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<TalentPoolCVResponse> saveCV(CreateTalentPoolCVRequest request) async {
    try {
      var response = await _apiHelper.patch(
          "/management/users", request.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return TalentPoolCVResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<TalentPoolJobCriteriaResponse?> fetchJobCriteriaByUserId(
      String userId) async {
    try {
      var response = await _apiHelper.get("/management/userCriteria/$userId");

      if (response["error"]) {
        return null;
      }

      return TalentPoolJobCriteriaResponse.fromMap(response["data"]);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<TalentPoolJobCriteriaResponse> saveJobCriteria(
      CreateTalentPoolJobCriteriaRequest request) async {
    try {
      var response = await _apiHelper.post(
          "/management/userCriteria/create", request.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return TalentPoolJobCriteriaResponse.fromMap(response["data"]);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<TalentPoolContractResponse> saveContract(
      CreateTalentPoolContractRequest contractRequest) async {
    try {
      var contractResponse = await _apiHelper.post(
          "/management/onDemand/contracts", contractRequest.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return TalentPoolContractResponse.fromMap(contractResponse);
    } on AppException catch (_) {
      rethrow;
    }
  }
}
