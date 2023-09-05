import 'package:kukerja_web/features/kukerja/freetalent/data/models/requests/create_freetalent_employer_request.dart';

abstract class FreetalentEmployerRepository {

  Future<void> create(CreateFreetalentEmployerRequest createFreetalentEmployerRequest);

}