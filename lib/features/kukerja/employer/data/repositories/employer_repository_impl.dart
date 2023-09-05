import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/requests/create_employer_request.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/responses/CreateEmployerResponse.dart';
import 'package:kukerja_web/features/kukerja/employer/domain/repositories/employer_repository.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class EmployerRepositoryImpl implements EmployerRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<CreateEmployerResponse> create(
      CreateEmployerRequest createEmployerRequest) async {
    try {
      var response = await _apiHelper.patch(
          "/management/users", createEmployerRequest.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return CreateEmployerResponse.fromHttpRequest(response);
    } on AppException {
      rethrow;
    }
  }
}
