import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_employer_information_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/find_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_bulk_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/candidate_reponse.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/send_interview_response.dart';

import '../../data/models/requests/send_interview_request.dart';
import '../../data/models/responses/employer_information_response.dart';

abstract class SultanRecruitmentRepository {
  Future<EmployerInformationResponse> confirmInformation(CreateEmployerInformationRequest request);

  Future<CandidateResponse> findCandidates(FindCandidateRequest request);

  @Deprecated("Use `sendBulkInterview` instead")
  Future<SendInterviewResponse> sendInterview(String jobId, SendInterviewRequest request);

  Future<SendInterviewResponse> sendBulkInterview(String jobId, SendBulkInterviewRequest request);
}