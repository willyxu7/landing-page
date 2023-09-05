import '../../../domain/entities/employee.dart';

class ApplicantResponse {
  late String _jobTitle = '';
  late String _employerName = '';
  late List<Employee> _employees = [];
  late int _totalApplicant = 0;

  String get jobTitle => _jobTitle;

  set jobTitle(String value) {
    _jobTitle = value;
  }

  String get employerName => _employerName;

  set employerName(String value) {
    _employerName = value;
  }

  List<Employee> get employees => _employees;

  set employees(List<Employee> value) {
    _employees = value;
  }

  int get totalApplicant => _totalApplicant;

  set totalApplicant(int value) {
    _totalApplicant = value;
  }
}
