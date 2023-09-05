import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/domain/entities/education_qualification.dart';
import 'package:kukerja_web/core/domain/entities/salary_type.dart';

class FindCandidate {
  late ProfessionDataResponse profession;
  late EducationQualification educationQualification;
  late SalaryType salaryType;
  late String gender, age, jobType, salary;
  late String? description;
  late List<String>? workingDays;
  late String startWork, endWork;

  FindCandidate(
      {required this.profession,
      required this.gender,
      required this.age,
      required this.educationQualification,
      required this.jobType,
      required this.salary,
      required this.salaryType,
      required this.workingDays,
      required this.startWork,
      required this.endWork,
      this.description});

  @override
  String toString() {
    return 'FindCandidate{profession: $profession, educationQualification: $educationQualification, gender: $gender, age: $age, jobType: $jobType, salary: $salary, salaryType: $salaryType, description: $description, workingDays: $workingDays, startWork: $startWork, endWork: $endWork}';
  }
}
