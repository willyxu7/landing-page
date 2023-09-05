import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employee_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_employer_information_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/find_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_job_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_bulk_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/candidate_reponse.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/employer_information_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/send_interview_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/domain/repositories/sultan_recruitment_repository.dart';

class SultanRecruitmentRepositoryImpl extends SultanRecruitmentRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<EmployerInformationResponse> confirmInformation(
      CreateEmployerInformationRequest request) async {
    try {
      var response = await _apiHelper.patch(
          "/management/users", request.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return EmployerInformationResponse.fromMap(response);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<CandidateResponse> findCandidates(FindCandidateRequest request) async {
    try {
      var response = await _apiHelper.post(
          "/management/users/recommendation", request.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      List<ProfileEmployeeResponse> profileEmployees =
          ProfileEmployeeResponse.listFromMap(response["data"]);

      return CandidateResponse(profileEmployees: profileEmployees);
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  @Deprecated("Use `sendBulkInterview` instead")
  Future<SendInterviewResponse> sendInterview(
      String jobId, SendInterviewRequest request) async {
    try {
      if (jobId.isEmpty) {
        String? jobRequest = await _storage.read(key: "jobRequest");
        var parsedJson = jsonDecode(jobRequest!);
        request.createJobRequest =
            CreateJobRequest.fromJson(parsedJson);
      }

      var response = await _apiHelper.post(
          "/management/onDemand/offers?jobId=$jobId",
          request.toJson(),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });

      return SendInterviewResponse.fromHttpRequest(response["offer"]);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<SendInterviewResponse> sendBulkInterview(
      String jobId, SendBulkInterviewRequest request) async {
    try {
      if (jobId.isEmpty) {
        String? jobRequest = await _storage.read(key: "jobRequest");
        var parsedJson = jsonDecode(jobRequest!);
        request.createJobRequest =
            CreateJobRequest.fromJson(parsedJson);
      }

      var response = await _apiHelper.post(
          "/management/onDemand/offers/sendInterview?jobId=$jobId",
          request.toJson(),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });

      return SendInterviewResponse.fromHttpRequest(response["offer"]);
    } on AppException {
      rethrow;
    }
  }
}
