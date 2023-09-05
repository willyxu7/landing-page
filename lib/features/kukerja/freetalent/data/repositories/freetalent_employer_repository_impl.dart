import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/freetalent/data/models/requests/create_freetalent_employer_request.dart';
import 'package:kukerja_web/features/kukerja/freetalent/domain/repositories/freetalent_employer_repository.dart';

class FreetalentEmployerRepositoryImpl implements FreetalentEmployerRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<void> create(
      CreateFreetalentEmployerRequest createFreetalentEmployerRequest) async {
    try {
      await _apiHelper.post(
          '/management/auth/register', createFreetalentEmployerRequest.toJson(),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          });
    } on AppException {
      rethrow;
    }
  }
}
