import 'package:kukerja_web/features/kukerja/employer/data/models/requests/create_employer_request.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/responses/CreateEmployerResponse.dart';
import 'package:kukerja_web/features/kukerja/employer/domain/repositories/employer_repository.dart';

import '../../../../../core/utils/local_storage_util.dart';

class EmployerUseCase {

  final EmployerRepository _employerRepository;

  EmployerUseCase(this._employerRepository);
  
  Future<CreateEmployerResponse> create(CreateEmployerRequest createEmployerRequest) async {
    CreateEmployerResponse createEmployerResponse = await _employerRepository.create(createEmployerRequest);

    if (createEmployerResponse.name.isNotEmpty) {
      await LocalStorageUtil.writeUserName(createEmployerResponse.name);
    }

    return createEmployerResponse;
  }

}