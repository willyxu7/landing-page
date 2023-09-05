import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_job_seeker_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/responses/create_job_seeker_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/domain/repositories/job_seeker_repository.dart';

class JobSeekerUseCase {
  final JobSeekerRepository _jobSeekerRepository;

  JobSeekerUseCase(this._jobSeekerRepository);

  Future<CreateJobSeekerResponse> create(
      CreateJobSeekerRequest createJobSeekerRequest) async {
    CreateJobSeekerResponse createJobSeekerResponse =
        await _jobSeekerRepository.create(createJobSeekerRequest);

    if (createJobSeekerResponse.name.isNotEmpty) {
      await LocalStorageUtil.writeUserName(createJobSeekerResponse.name);
    }

    return createJobSeekerResponse;
  }
}
