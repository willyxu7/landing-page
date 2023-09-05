import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/job_details_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/repositories/job_details_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/job_details_repository.dart';

class JobDetailsUseCase {
  JobDetailsRepository get _jobDetailsRepository => JobDetailsRepositoryImpl();

  Future<JobDetailsResponse> getJobDetails(String id) {
    return _jobDetailsRepository.getJobDetails(id);
  }
}
