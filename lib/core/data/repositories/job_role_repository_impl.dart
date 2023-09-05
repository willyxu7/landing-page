import 'package:kukerja_web/core/data/models/responses/job_role_response.dart';
import 'package:kukerja_web/core/domain/entities/job_role.dart';
import 'package:kukerja_web/core/domain/repositories/job_role_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class JobRoleRepositoryImpl implements JobRoleRepository {
 final  APIHelper _apiHelper = APIHelper();

  @override
  Future<List<JobRole>> fetchAll() async {
    List<JobRole> jobRoles = [];

    try {
      var response = await _apiHelper.get('/management/onDemand/jobRoles');

      jobRoles = response['data']
          .map<JobRole>((jobRole) => JobRoleResponse.fromJson(jobRole))
          .toList();

    } on AppException {
      rethrow;
    }

    return jobRoles;
  }
}
