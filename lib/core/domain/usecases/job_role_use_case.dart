import 'package:kukerja_web/core/domain/repositories/job_role_repository.dart';

import '../entities/job_role.dart';

class JobRoleUseCase {
  final JobRoleRepository _jobRoleRepository;

  JobRoleUseCase(this._jobRoleRepository);

  Future<List<JobRole>> fetchAll() async {
    return await _jobRoleRepository.fetchAll();
  }

}