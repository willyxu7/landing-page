import 'package:kukerja_web/core/domain/entities/job_role.dart';

abstract class JobRoleRepository {

  Future<List<JobRole>> fetchAll();

}