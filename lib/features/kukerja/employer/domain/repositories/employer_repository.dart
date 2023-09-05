import 'package:kukerja_web/features/kukerja/employer/data/models/requests/create_employer_request.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/responses/CreateEmployerResponse.dart';

abstract class EmployerRepository {

  Future<CreateEmployerResponse> create(CreateEmployerRequest createEmployerRequest);

}