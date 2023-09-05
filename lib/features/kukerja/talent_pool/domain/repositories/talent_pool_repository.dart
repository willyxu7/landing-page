import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_contract_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_cv_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_job_criteria_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_cv_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_job_criteria_response.dart';

abstract class TalentPoolRepository {
  Future<TalentPoolCVResponse> saveCV(CreateTalentPoolCVRequest request);

  Future<TalentPoolJobCriteriaResponse?> fetchJobCriteriaByUserId(String userId);

  Future<TalentPoolJobCriteriaResponse> saveJobCriteria(
      CreateTalentPoolJobCriteriaRequest request);

  Future<TalentPoolContractResponse> saveContract(CreateTalentPoolContractRequest contractRequest);
}
