import 'package:flutter/material.dart';
import 'package:kukerja_web/core/data/datasources/local_data/religion_local_data.dart';
import 'package:kukerja_web/core/data/models/responses/education_response.dart';
import 'package:kukerja_web/core/data/repositories/city_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/education_level_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/education_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/industry_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/profession_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/religion_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/api_status.dart';
import 'package:kukerja_web/core/domain/usecases/city_usecase.dart';
import 'package:kukerja_web/core/domain/usecases/education_level_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/education_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/industry_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/profession_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/religion_use_case.dart';
import 'package:kukerja_web/core/exceptions/bad_request_exception.dart';
import 'package:kukerja_web/core/exceptions/fetch_data_exception.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_experience_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_job_seeker_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/update_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/update_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/update_experience_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/responses/create_job_seeker_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/repositories/job_seeker_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/domain/usecases/job_seeker_use_case.dart';

class JobSeekerProvider with ChangeNotifier {
  // Variable Section
  final APIResponse apiResponse = APIResponse(APIStatus.loading);
  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());
  final EducationUseCase _educationUseCase =
      EducationUseCase(EducationRepositoryImpl());
  final EducationLevelUseCase _educationLevelUseCase =
      EducationLevelUseCase(EducationLevelRepositoryImpl());
  final IndustryUseCase _industryUseCase =
      IndustryUseCase(IndustryRepositoryImpl());
  final JobSeekerUseCase _jobSeekerUseCase =
      JobSeekerUseCase(JobSeekerRepositoryImpl());
  final ProfessionUseCase _professionUseCase =
      ProfessionUseCase(ProfessionRepositoryImpl());
  final ReligionUseCase _religionUseCase =
      ReligionUseCase(ReligionRepositoryImpl(ReligionLocalData()));

  late EducationResponse education;

  late List<String> cities, educationLevels, industries, professions, religions;
  late List<CreateEducationFormalRequest> educationFormalRequests = [];
  late List<CreateEducationNonFormalRequest> educationNonFormalRequests = [];
  late List<CreateExperienceRequest> experienceRequests = [];

  // End Variable Section

  // Setter & Getter Section

  set addEducationFormal(CreateEducationFormalRequest educationFormalRequest) {
    educationFormalRequests.add(educationFormalRequest);
    notifyListeners();
  }

  set deleteEducationFormal(String indexWidget) {
    educationFormalRequests
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  set addEducationNonFormal(
      CreateEducationNonFormalRequest educationNonFormalRequest) {
    educationNonFormalRequests.add(educationNonFormalRequest);
    notifyListeners();
  }

  set deleteEducationNonFormal(String indexWidget) {
    educationNonFormalRequests
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  set addExperience(CreateExperienceRequest experienceRequest) {
    experienceRequests.add(experienceRequest);
    notifyListeners();
  }

  set deleteExperience(String indexWidget) {
    experienceRequests
        .removeWhere((request) => request.indexWidget == indexWidget);
    notifyListeners();
  }

  // End Setter & Getter Section

  // Method Section

  void updateEducationFormal(
      String indexWidget, UpdateEducationFormalRequest request) {
    var chosenEducationFormal = educationFormalRequests
        .firstWhere((request) => request.indexWidget == indexWidget);

    if (request.isStillStudying) request.endYear = "";

    chosenEducationFormal
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
    var educationNonFormal = educationNonFormalRequests
        .firstWhere((request) => request.indexWidget == indexWidget);

    educationNonFormal
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
    var experience = experienceRequests
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

  Future<CreateJobSeekerResponse> create(CreateJobSeekerRequest createJobSeekerRequest) async {
    return await _jobSeekerUseCase.create(createJobSeekerRequest);
  }

  Future<void> initData() async {
    try {
      var cityResponse = await _cityUseCase.fetchCities();
      cities = cityResponse.map((city) => city.name).toList();

      education = await _educationUseCase.fetchEducations();

      var educationLevelResponse =
          await _educationLevelUseCase.fetchEducationLevels();
      educationLevels = educationLevelResponse.educations;

      var industryResponse = await _industryUseCase.fetchIndustries();
      industries = industryResponse.industries;

      var professionResponse = await _professionUseCase.fetchProfessions();
      professions = professionResponse.professions;

      religions = _religionUseCase.getReligions();

      apiResponse.setCompleted();
    } catch (e) {
      print(e);
      if (e is BadRequestException) {
        apiResponse.setError("Fetch data gagal");
      } else if (e is FetchDataException) {
        apiResponse.setError("Terjadi masalah di server $e");
      }
    }

    notifyListeners();
  }

// End Method Section

}
