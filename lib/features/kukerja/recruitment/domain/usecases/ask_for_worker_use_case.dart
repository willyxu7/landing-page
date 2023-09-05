import 'package:kukerja_web/features/kukerja/recruitment/data/models/request/ask_for_worker_request.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/repositories/ask_for_worker_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/ask_for_worker_repository.dart';

class AskForWorkerUseCase {
  final AskForWorkerRepository _askForWorkerRepository =
      AskForWorkerRepositoryImpl();

  Future<void> postAskForWorker(AskForWorkerRequest askForWorkerRequest) async {
    await _askForWorkerRepository.postAskForWorker(askForWorkerRequest);
  }
}
