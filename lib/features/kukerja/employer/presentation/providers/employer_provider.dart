import 'package:flutter/material.dart';
import 'package:kukerja_web/core/data/models/responses/city_response.dart';
import 'package:kukerja_web/core/data/repositories/city_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/industry_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/api_status.dart';
import 'package:kukerja_web/core/domain/usecases/city_usecase.dart';
import 'package:kukerja_web/core/domain/usecases/industry_use_case.dart';
import 'package:kukerja_web/core/helpers/api_response.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/requests/create_employer_request.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/responses/CreateEmployerResponse.dart';
import 'package:kukerja_web/features/kukerja/employer/data/repositories/employer_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/employer/domain/usecases/employer_use_case.dart';

import '../../../../../core/data/models/responses/industry_response.dart';
import '../../../../../core/exceptions/bad_request_exception.dart';
import '../../../../../core/exceptions/fetch_data_exception.dart';

class EmployerProvider with ChangeNotifier {
  //Variable Section
  final APIResponse _apiResponse = APIResponse(APIStatus.loading);

  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());
  final EmployerUseCase _employerUseCase =
      EmployerUseCase(EmployerRepositoryImpl());
  final IndustryUseCase _industryUseCase =
      IndustryUseCase(IndustryRepositoryImpl());

  late List<CityResponse> _cityResponses;
  late IndustryResponse _industryResponse;

  //Variable End Section

  //===============================================================

  //Getter Section

  APIResponse get apiResponse => _apiResponse;

  List<String> get industries => _industryResponse.industries;

  List<CityResponse> get cities => _cityResponses;

  //Getter End Section

  //===============================================================

  //Method Section

  Future<CreateEmployerResponse> createEmployer(CreateEmployerRequest createEmployerRequest) async {
    return await _employerUseCase.create(createEmployerRequest);
  }

  Future<void> initData() async {
    try {
      _cityResponses = await _cityUseCase.fetchCities();

      _industryResponse = await _industryUseCase.fetchIndustries();

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
}
