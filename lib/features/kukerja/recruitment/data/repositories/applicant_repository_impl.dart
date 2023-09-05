import 'dart:convert';

import 'package:kukerja_web/features/kukerja/recruitment/data/mapper/experience_mapper.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/applicant_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/employee.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/applicant_repository.dart';

import 'package:http/http.dart' as http;

import '../../../../../env/prod_env.dart';
import '../../domain/entities/experience.dart';

class ApplicantRepositoryImpl implements ApplicantRepository {
  @override
  Future<ApplicantResponse> getApplicants(String id) async {
    ApplicantResponse applicantResponse = ApplicantResponse();
    List<Experience> experiences = [];

    var response = await http.get(Uri.parse(
        '${ProdEnv.apiURL}/management/applicants/applicants-web/$id'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var json = responseBody['data'];

      if (responseBody['count'] != 0) {
        applicantResponse.jobTitle = json['jobTitle'];
        applicantResponse.employerName = json['employer']['employerName'];
        applicantResponse.totalApplicant = responseBody['count'];

        for (var employee in json['employees']) {
          for (var experience in employee['employeeExperience']) {
            experiences.add(
                ExperienceMapper.mapEmployeeExperienceJsonToExperience(
                    experience));
          }

          applicantResponse.employees.add(Employee(
              id: employee['employeeId'],
              name: employee['employeeName'],
              imageProfileUrl: employee['employeeImageUrl'],
              experiences: experiences));

          experiences = [];
        }
      }
    } else {
      throw Exception('Failed to load applicants');
    }

    return applicantResponse;
  }
}
