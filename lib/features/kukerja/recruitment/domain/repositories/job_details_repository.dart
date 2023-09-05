import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/job_details_response.dart';

abstract class JobDetailsRepository {
  Future<JobDetailsResponse> getJobDetails(String id);
}
