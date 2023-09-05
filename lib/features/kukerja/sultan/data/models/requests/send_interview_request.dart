import 'dart:convert';

import 'package:flutter/material.dart';

import 'create_job_request.dart';
import 'find_candidate_request.dart';

@Deprecated("Use `SendBulkInterviewRequest` instead")
class SendInterviewRequest {
  late List<String> employeeIds;
  late String employerId;
  late String interviewLocation;
  TimeOfDay? interviewTime;
  DateTime? interviewDate;
  FindCandidateRequest findCandidateRequest;
  CreateJobRequest? createJobRequest;

  SendInterviewRequest(
      {required this.employeeIds,
      required this.employerId,
      required this.interviewLocation,
      required this.interviewTime,
      required this.interviewDate,
      required this.findCandidateRequest,
      this.createJobRequest});

  Map<String, dynamic> toMap() => {
        "employeesId": employeeIds,
        "employerId": employerId,
        "interviewDetail": {
          "location": interviewLocation,
          "dateInterview": DateTime(
                  interviewDate!.year,
                  interviewDate!.month,
                  interviewDate!.day,
                  interviewTime!.hour,
                  interviewTime!.minute)
              .toIso8601String()
        },
        "experience": findCandidateRequest.experience,
        "education_level": findCandidateRequest.educationLevels,
        "gender": findCandidateRequest.gender == "Pria & Wanita"
            ? null
            : findCandidateRequest.gender,
        "age": findCandidateRequest.age == "Bebas"
            ? null
            : findCandidateRequest.age,
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
