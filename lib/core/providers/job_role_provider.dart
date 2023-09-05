import 'package:flutter/cupertino.dart';
import 'package:kukerja_web/core/data/repositories/job_role_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/job_role.dart';
import 'package:kukerja_web/core/domain/usecases/job_role_use_case.dart';

class JobRoleProvider with ChangeNotifier {
  final JobRoleUseCase _jobRoleUseCase =
      JobRoleUseCase(JobRoleRepositoryImpl());

  List<JobRole> _jobRoles = [];
  bool _isLoading = true;
  String _selectedJobRole = '';

  bool get isLoading => _isLoading;

  String get selectedJobRole => _selectedJobRole;

  List<JobRole> get jobRoles => _jobRoles;

  set jobRoles(List<JobRole> jobRoles) {
    _jobRoles = jobRoles;
    _isLoading = false;
    notifyListeners();
  }

  set selectedJobRole(String jobRole) {
    _selectedJobRole = jobRole;
    notifyListeners();
  }

  Future<List<JobRole>> fetchAll() async {
    return await _jobRoleUseCase.fetchAll();
  }
}
