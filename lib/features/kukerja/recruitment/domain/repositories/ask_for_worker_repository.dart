import 'package:kukerja_web/features/kukerja/recruitment/data/models/request/ask_for_worker_request.dart';

abstract class AskForWorkerRepository {

  Future<void> postAskForWorker(AskForWorkerRequest askForWorkerRequest);

}