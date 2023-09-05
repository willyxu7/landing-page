import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_contract_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_cv_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_job_criteria_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_cv_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_job_criteria_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/domain/repositories/talent_pool_repository.dart';

class TalentPoolUseCase {
  final TalentPoolRepository _talentPoolRepository;

  TalentPoolUseCase(this._talentPoolRepository);

  Future<TalentPoolCVResponse> saveCV(CreateTalentPoolCVRequest request) {
    return _talentPoolRepository.saveCV(request);
  }

  Future<TalentPoolJobCriteriaResponse?> fetchJobCriteriaByUserId(
      String userId) {
    return _talentPoolRepository.fetchJobCriteriaByUserId(userId);
  }

  Future<TalentPoolJobCriteriaResponse> saveJobCriteria(
      CreateTalentPoolJobCriteriaRequest request) async {
    return await _talentPoolRepository.saveJobCriteria(request);
  }

  Future<TalentPoolContractResponse> saveContract(
      CreateTalentPoolContractRequest contractRequest) async {
    return await _talentPoolRepository.saveContract(contractRequest);
  }
}
