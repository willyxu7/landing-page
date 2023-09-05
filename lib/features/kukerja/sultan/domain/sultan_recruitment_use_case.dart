import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_employer_information_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/find_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_bulk_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/candidate_reponse.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/employer_information_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/send_interview_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/domain/repositories/sultan_recruitment_repository.dart';

class SultanRecruitmentUseCase {
  final SultanRecruitmentRepository _sultanRecruitmentRepository;

  SultanRecruitmentUseCase(this._sultanRecruitmentRepository);

  Future<EmployerInformationResponse> confirmInformation(
      CreateEmployerInformationRequest request) {
    return _sultanRecruitmentRepository.confirmInformation(request);
  }

  Future<CandidateResponse> findCandidates(FindCandidateRequest request) {
    return _sultanRecruitmentRepository.findCandidates(request);
  }

  @Deprecated("Use `sendBulkInterview` instead")
  Future<SendInterviewResponse> sendInterview(
      String jobId, SendInterviewRequest request) async {
    return await _sultanRecruitmentRepository.sendInterview(jobId, request);
  }

  Future<SendInterviewResponse> sendBulkInterview(
      String jobId, SendBulkInterviewRequest request) async {
    return await _sultanRecruitmentRepository.sendBulkInterview(jobId, request);
  }
}
