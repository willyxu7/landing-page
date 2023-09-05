import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_job_seeker_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/responses/create_job_seeker_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/domain/repositories/job_seeker_repository.dart';

class JobSeekerRepositoryImpl implements JobSeekerRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<CreateJobSeekerResponse> create(
      CreateJobSeekerRequest createJobSeekerRequest) async {
    try {
      var response = await _apiHelper.patch(
          "/management/users", createJobSeekerRequest.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return CreateJobSeekerResponse.fromHttpRequest(response);
    } on AppException {
      rethrow;
    }
  }
}
