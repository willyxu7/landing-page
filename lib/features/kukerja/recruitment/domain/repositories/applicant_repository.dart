import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/applicant_response.dart';

abstract class ApplicantRepository {
  Future<ApplicantResponse> getApplicants(String id);
}