import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/city_response.dart';
import 'package:kukerja_web/core/data/models/responses/industry_response.dart';
import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/data/repositories/authentication_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/industry_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/profession_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/user_repository_impl.dart';
import 'package:kukerja_web/core/domain/usecases/authentication_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/city_usecase.dart';
import 'package:kukerja_web/core/domain/usecases/industry_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/profession_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/user_use_case.dart';
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employee_response.dart';
import 'package:kukerja_web/core/domain/entities/api_status.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/find_candidate.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_employer_information_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_job_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/find_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_bulk_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/candidate_reponse.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/employer_information_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/send_interview_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/selected_candidate.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/repositories/sultan_recruitment_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/sultan/domain/sultan_recruitment_use_case.dart';
import 'package:kukerja_web/core/domain/entities/user.dart';

import '../../../../../core/data/repositories/city_repository_impl.dart';
import '../../../../../core/exceptions/bad_request_exception.dart';
import '../../../../../core/exceptions/fetch_data_exception.dart';

class SultanRecruitmentProvider with ChangeNotifier {
  //Variable Section

  final PageController pageController = PageController();
  final APIResponse _apiResponse = APIResponse(APIStatus.loading);
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final ProfessionUseCase _professionUseCase =
      ProfessionUseCase(ProfessionRepositoryImpl());
  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());
  final AuthenticationUseCase _authenticationUseCase =
      AuthenticationUseCase(AuthenticationRepositoryImpl());
  final SultanRecruitmentUseCase _sultanRecruitmentUseCase =
      SultanRecruitmentUseCase(SultanRecruitmentRepositoryImpl());
  final UserUseCase _userUseCase = UserUseCase(UserRepositoryImpl());
  final IndustryUseCase _industryUseCase =
      IndustryUseCase(IndustryRepositoryImpl());

  List<ProfessionDataResponse>? _professionDataResponses;
  List<CityResponse>? _cityResponses;
  final List<SelectedCandidate> _selectedCandidates = [];
  late List<ProfileEmployeeResponse> _profileEmployeeResponses;
  final List<ProfileEmployeeResponse> _profileEmployeeResponsesTrash = [];
  FindCandidateRequest? findCandidateRequest;
  FindCandidate? findCandidate;
  IndustryResponse? _industryResponse;

  bool _isOtpLoading = false;

  String selectedCity = "";

  String? _jobId;

  APIResponse get apiResponse => _apiResponse;

  int baseOtpCounter = 60;
  int resendOtpCounter = 60;

  //End Variable Section

  // Setter & Getter Section

  List<ProfessionDataResponse>? get professionDataResponses =>
      _professionDataResponses;

  List<String>? get cities => _cityResponses?.map((city) => city.name).toList();

  List<String>? get industries => _industryResponse?.industries;

  bool get isOtpLoading => _isOtpLoading;

  set isOtpLoading(bool isOtpLoading) {
    _isOtpLoading = isOtpLoading;
    notifyListeners();
  }

  String get jobId => _jobId ?? "";

  set jobId(String jobId) {
    _jobId = jobId;
    notifyListeners();
  }

  List<ProfileEmployeeResponse> get profileEmployeeResponses =>
      _profileEmployeeResponses;

  void setProfileEmployeeResponses(
      List<ProfileEmployeeResponse> profileEmployees) {
    _profileEmployeeResponses = profileEmployees;
    notifyListeners();
  }

  List<SelectedCandidate> get selectedCandidates => _selectedCandidates;

  void addSelectedCandidates(SelectedCandidate selectedCandidate) {
    _selectedCandidates.add(selectedCandidate);
    notifyListeners();
  }

  // End Setter & Getter Section

  //Method Section

  bool canResendOtp() {
    return resendOtpCounter == baseOtpCounter;
  }

  void clearSelectedCandidates() {
    _selectedCandidates.clear();
    notifyListeners();
  }

  void startOtpCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      resendOtpCounter--;
      notifyListeners();

      if (resendOtpCounter == 0) {
        resendOtpCounter = 60;
        timer.cancel();
      }
    });
  }

  void removeProfileEmployeeResponsesById(String id) {
    var selectedEmployee = _profileEmployeeResponses
        .firstWhere((profileEmployee) => profileEmployee.id == id);

    _profileEmployeeResponsesTrash.add(selectedEmployee);

    _profileEmployeeResponses
        .removeWhere((profileEmployee) => profileEmployee.id == id);

    notifyListeners();
  }

  void updateSelectedCandidate(SelectedCandidate selectedCandidate) {
    int index = _selectedCandidates
        .indexWhere((candidate) => candidate.id == selectedCandidate.id);

    _selectedCandidates[index].interviewDate = selectedCandidate.interviewDate;
    _selectedCandidates[index].interviewTime = selectedCandidate.interviewTime;

    notifyListeners();
  }

  void removeSelectedCandidatesById(String id) {
    var selectedCandidate = _profileEmployeeResponsesTrash
        .firstWhere((candidate) => candidate.id == id);

    _profileEmployeeResponses.add(selectedCandidate);

    _selectedCandidates.removeWhere((candidate) => candidate.id == id);

    _profileEmployeeResponsesTrash
        .removeWhere((profileEmployee) => profileEmployee.id == id);

    notifyListeners();
  }

  Future<RegisByFirebaseOtpResponse> regisByFirebaseOtp(
      RegisByFirebaseOtpRequest request) async {
    late RegisByFirebaseOtpResponse regisByFirebaseOtpResponse;

    try {
      regisByFirebaseOtpResponse =
          await _authenticationUseCase.regisByFirebaseOtp(request);
    } on InternalServerErrorException catch (_) {
      rethrow;
    }

    return regisByFirebaseOtpResponse;
  }

  Future<User> fetchProfile() async => await _userUseCase.fetchProfile();

  Future<EmployerInformationResponse> confirmInformation(
      CreateEmployerInformationRequest request) async {
    return await _sultanRecruitmentUseCase.confirmInformation(request);
  }

  Future<CandidateResponse> findCandidates(FindCandidateRequest request) async {
    try {
      return await _sultanRecruitmentUseCase.findCandidates(request);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> storeCreateJobRequestToLocalStore(
      CreateJobRequest createJobRequest) async {
    await _storage.write(key: "jobRequest", value: createJobRequest.toJson());
  }

  @Deprecated("Use `sendBulkInterview` instead")
  Future<SendInterviewResponse> sendInterview(
      String jobId, SendInterviewRequest request) async {
    return await _sultanRecruitmentUseCase.sendInterview(jobId, request);
  }

  Future<SendInterviewResponse> sendBulkInterview(
      String jobId, SendBulkInterviewRequest request) async {
    return await _sultanRecruitmentUseCase.sendBulkInterview(jobId, request);
  }

  Future<void> initData() async {
    try {
      _professionDataResponses =
          await _professionUseCase.fetchDataProfessions();

      _cityResponses = await _cityUseCase.fetchCities();

      _industryResponse = await _industryUseCase.fetchIndustries();

      _apiResponse.setCompleted();
    } catch (e) {
      if (e is BadRequestException) {
        _apiResponse.setError("Fetch data gagal");
      } else if (e is FetchDataException) {
        _apiResponse.setError("Terjadi masalah di server $e");
      }
    }

    notifyListeners();
  }

// End Method Section

}
