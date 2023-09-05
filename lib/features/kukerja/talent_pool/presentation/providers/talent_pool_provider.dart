import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kukerja_web/core/data/datasources/local_data/religion_local_data.dart';
import 'package:kukerja_web/core/data/models/responses/bank_response.dart';
import 'package:kukerja_web/core/data/models/responses/education_level_response.dart';
import 'package:kukerja_web/core/data/models/responses/education_response.dart';
import 'package:kukerja_web/core/data/models/responses/industry_response.dart';
import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/data/models/responses/profession_response.dart';
import 'package:kukerja_web/core/data/repositories/authentication_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/bank_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/city_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/education_level_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/education_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/industry_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/profession_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/religion_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/user_repository_impl.dart';
import 'package:kukerja_web/core/domain/usecases/authentication_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/bank_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/city_usecase.dart';
import 'package:kukerja_web/core/domain/usecases/education_level_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/education_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/industry_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/profession_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/religion_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/user_use_case.dart';
import 'package:kukerja_web/core/exceptions/bad_request_exception.dart';
import 'package:kukerja_web/core/exceptions/fetch_data_exception.dart';
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_contract_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_cv_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_job_criteria_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/update_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/update_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/update_experience_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_cv_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_job_criteria_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/repositories/talent_pool_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/domain/usecases/talent_pool_use_case.dart';
import 'package:signature/signature.dart';

import '../../../../../core/data/models/requests/regis_by_firebase_otp_request.dart';
import '../../../../../core/data/models/responses/regis_by_firebase_otp_response.dart';
import '../../../../../core/domain/entities/user.dart';
import '../../../../../core/domain/entities/api_status.dart';
import '../../data/models/requests/create_experience_request.dart';

class TalentPoolProvider with ChangeNotifier {
  // Variable Section

  final PageController _pageController = PageController();
  final AuthenticationUseCase _authenticationUseCase =
      AuthenticationUseCase(AuthenticationRepositoryImpl());
  final ReligionUseCase _religionUseCase =
      ReligionUseCase(ReligionRepositoryImpl(ReligionLocalData()));
  final EducationUseCase _educationUseCase =
      EducationUseCase(EducationRepositoryImpl());
  final EducationLevelUseCase _educationLevelUseCase =
      EducationLevelUseCase(EducationLevelRepositoryImpl());
  final IndustryUseCase _industryUseCase =
      IndustryUseCase(IndustryRepositoryImpl());
  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());
  final ProfessionUseCase _professionUseCase =
      ProfessionUseCase(ProfessionRepositoryImpl());
  final BankUseCase _bankUseCase = BankUseCase(BankRepositoryImpl());
  final TalentPoolUseCase _talentPoolUseCase =
      TalentPoolUseCase(TalentPoolRepositoryImpl());
  final UserUseCase _userUseCase = UserUseCase(UserRepositoryImpl());

  bool _isAgree = false, _isOtpLoading = false;

  int baseOtpCounter = 60;
  int resendOtpCounter = 60;

  String? loggedInUserId;
  late EducationResponse _educationResponse;
  late EducationLevelResponse _educationLevelResponse;
  late IndustryResponse _industryResponse;
  late ProfessionResponse _professionResponse;
  late List<ProfessionDataResponse> _professionDataResponses;
  late TalentPoolCVResponse _talentPoolCVResponse;
  late BankResponse _bankResponse;
  late List<String> _cities;
  List<CreateEducationFormalRequest>? _educationFormalRequests = [];
  List<CreateEducationNonFormalRequest>? _educationNonFormalRequests = [];
  List<CreateExperienceRequest>? _experienceRequests = [];

  //End Variable Section

  // Setter & Getter Section

  PageController get pageController => _pageController;

  final APIResponse _apiResponse = APIResponse(APIStatus.loading);

  get apiResponse => _apiResponse;

  List<String> get religions => _religionUseCase.getReligions();

  EducationResponse get education => _educationResponse;

  List<String> get educationLevels => _educationLevelResponse.educations;

  List<String> get industries => _industryResponse.industries;

  List<String> get professions => _professionResponse.professions;

  List<ProfessionDataResponse> get professionData => _professionDataResponses;

  List<String> get banks => _bankResponse.banks;

  List<String> get cities => _cities;

  bool get isAgree => _isAgree;

  bool get isOtpLoading => _isOtpLoading;

  set isOtpLoading(bool isOtpLoading) {
    _isOtpLoading = isOtpLoading;
    notifyListeners();
  }

  set addEducationFormal(CreateEducationFormalRequest educationFormalRequest) {
    _educationFormalRequests?.add(educationFormalRequest);
    notifyListeners();
  }

  set deleteEducationFormal(String indexWidget) {
    _educationFormalRequests!
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  List<CreateEducationFormalRequest> get educationFormalRequests =>
      _educationFormalRequests!;

  set addEducationNonFormal(
      CreateEducationNonFormalRequest educationNonFormalRequest) {
    _educationNonFormalRequests?.add(educationNonFormalRequest);
    notifyListeners();
  }

  set deleteEducationNonFormal(String indexWidget) {
    _educationNonFormalRequests!
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  List<CreateEducationNonFormalRequest> get educationNonFormalRequests =>
      _educationNonFormalRequests!;

  set addExperience(CreateExperienceRequest experienceRequest) {
    _experienceRequests?.add(experienceRequest);
    notifyListeners();
  }

  set deleteExperience(String indexWidget) {
    _experienceRequests!
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  List<CreateExperienceRequest> get experienceRequests => _experienceRequests!;

  TalentPoolCVResponse get talentPoolCVResponse => _talentPoolCVResponse;

  set talentPoolCVResponse(TalentPoolCVResponse talentPoolCVResponse) {
    _talentPoolCVResponse = talentPoolCVResponse;
    notifyListeners();
  }

  // End Setter & Getter Section

  // Method Section

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

  bool canResendOtp() {
    return resendOtpCounter == baseOtpCounter;
  }

  void isSignatureEmpty(SignatureController signatureController) {
    if (signatureController.isNotEmpty) {
      _isAgree = true;
    } else {
      _isAgree = false;
    }

    notifyListeners();
  }

  void updateEducationFormal(
      String indexWidget, UpdateEducationFormalRequest request) {
    var chosenEducationFormal = _educationFormalRequests
        ?.firstWhere((request) => request.indexWidget == indexWidget);

    if (request.isStillStudying) request.endYear = "";

    chosenEducationFormal!
      ..educationLevel = request.educationLevel
      ..educationPlace = request.educationPlace
      ..studyProgram = request.studyProgram
      ..educationExperience = request.educationExperience
      ..isStillStudying = request.isStillStudying
      ..startYear = request.startYear
      ..endYear = request.endYear
      ..certificate = request.certificate;
    notifyListeners();
  }

  void updateEducationNonFormal(
      String indexWidget, UpdateEducationNonFormalRequest request) {
    var educationNonFormal = _educationNonFormalRequests
        ?.firstWhere((request) => request.indexWidget == indexWidget);

    educationNonFormal!
      ..educationPlace = request.educationPlace
      ..course = request.course
      ..educationExperience = request.educationExperience
      ..isStillStudying = request.isStillStudying
      ..startYear = request.startYear
      ..endYear = request.endYear
      ..certificate = request.certificate;

    notifyListeners();
  }

  void updateExperience(String indexWidget, UpdateExperienceRequest request) {
    var experience = _experienceRequests!
        .firstWhere((request) => request.indexWidget == indexWidget);

    experience
      ..companyName = request.companyName
      ..profession = request.profession
      ..industry = request.industry
      ..experience = request.experience!
      ..startMonth = request.startMonth
      ..endMonth = request.endMonth
      ..startYear = request.startYear
      ..endYear = request.endYear;

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

  Future<TalentPoolCVResponse> saveCV(CreateTalentPoolCVRequest request) async {
    _talentPoolCVResponse = await _talentPoolUseCase.saveCV(request);
    return _talentPoolCVResponse;
  }

  Future<TalentPoolJobCriteriaResponse?> fetchJobCriteriaByUserId(
      String userId) async {
    return await _talentPoolUseCase.fetchJobCriteriaByUserId(userId);
  }

  Future<TalentPoolJobCriteriaResponse> saveJobCriteria(
      CreateTalentPoolJobCriteriaRequest request) async {
    return await _talentPoolUseCase.saveJobCriteria(request);
  }

  Future<TalentPoolContractResponse> saveContract(
      CreateTalentPoolContractRequest contractRequest) async {
    return await _talentPoolUseCase.saveContract(contractRequest);
  }

  Future<User> fetchProfile() async => await _userUseCase.fetchProfile();

  Future<void> initData() async {
    try {
      _educationResponse = await _educationUseCase.fetchEducations();

      _educationLevelResponse =
          await _educationLevelUseCase.fetchEducationLevels();

      _industryResponse = await _industryUseCase.fetchIndustries();

      _professionResponse = await _professionUseCase.fetchProfessions();

      _professionDataResponses =
          await _professionUseCase.fetchDataProfessions();

      _bankResponse = await _bankUseCase.fetchBanks();

      var cityResponse = await _cityUseCase.fetchCities();
      _cities = cityResponse.map((city) => city.name).toList();

      _apiResponse.setCompleted();
    } catch (e) {
      print(e);
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
