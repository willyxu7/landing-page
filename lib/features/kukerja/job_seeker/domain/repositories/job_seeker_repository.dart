import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_job_seeker_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/responses/create_job_seeker_response.dart';

abstract class JobSeekerRepository {

  Future<CreateJobSeekerResponse> create(CreateJobSeekerRequest createJobSeekerRequest);

}