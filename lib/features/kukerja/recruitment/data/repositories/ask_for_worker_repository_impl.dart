import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/request/ask_for_worker_request.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/ask_for_worker_repository.dart';

class AskForWorkerRepositoryImpl implements AskForWorkerRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<void> postAskForWorker(AskForWorkerRequest askForWorkerRequest) async {
    try {
      await _apiHelper.post('/url', askForWorkerRequest.toJson());
    } on AppException catch (_) {
      rethrow;
    }
  }
}
