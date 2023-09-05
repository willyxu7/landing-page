import 'package:kukerja_web/features/kukerja/freetalent/data/models/requests/create_freetalent_employer_request.dart';
import 'package:kukerja_web/features/kukerja/freetalent/data/repositories/freetalent_employer_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/freetalent/domain/repositories/freetalent_employer_repository.dart';

class FreetalentEmployerUseCase {
  final FreetalentEmployerRepository _freetalentEmployerRepository =
      FreetalentEmployerRepositoryImpl();

  Future<void> create(CreateFreetalentEmployerRequest createFreetalentEmployerRequest) async {
    await _freetalentEmployerRepository.create(createFreetalentEmployerRequest);
  }
}
