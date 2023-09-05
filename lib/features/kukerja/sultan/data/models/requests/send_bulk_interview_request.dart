import 'dart:convert';

import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/selected_candidate_request.dart';

import 'create_job_request.dart';
import 'find_candidate_request.dart';

class SendBulkInterviewRequest {
  late List<SelectedCandidateRequest> employees;
  late String employerId;
  late String location;
  late FindCandidateRequest findCandidateRequest;
  CreateJobRequest? createJobRequest;

  SendBulkInterviewRequest(
      {required this.employees,
      required this.employerId,
      required this.location,
      required this.findCandidateRequest,
      this.createJobRequest});

  Map<String, dynamic> toMap() => {
        "employees": employees.map((employee) => employee.toMap()).toList(),
        "employerId": employerId,
        "location": location,
        "experience": findCandidateRequest.experience,
        "education_level": findCandidateRequest.educationLevels,
        "gender": findCandidateRequest.gender == "Pria & Wanita"
            ? null
            : findCandidateRequest.gender,
        "age": findCandidateRequest.age,
        "city": findCandidateRequest.city,
        "description": createJobRequest?.jobDescription,
        "type_job": createJobRequest?.jobType,
        "type_salary": createJobRequest?.salaryType,
        "working_hour": createJobRequest?.workingHour,
        "salaryStart": createJobRequest?.salary,
        "working_day": createJobRequest?.workingDays
      };

  String toJson() => jsonEncode(toMap());
}
