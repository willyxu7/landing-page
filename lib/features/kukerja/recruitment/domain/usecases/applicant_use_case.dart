import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/applicant_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/repositories/applicant_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/applicant_repository.dart';

class ApplicantUseCase {
  final ApplicantRepository _applicantRepository = ApplicantRepositoryImpl();

  Future<ApplicantResponse> getApplicants(String id) {
    return _applicantRepository.getApplicants(id);
  }
}