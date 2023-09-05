import 'package:kukerja_web/core/domain/repositories/profession_repository.dart';
import '../../data/models/responses/profession_data_response.dart';

import '../../data/models/responses/profession_response.dart';

class ProfessionUseCase {
  final ProfessionRepository _professionRepository;

  ProfessionUseCase(this._professionRepository);

  Future<ProfessionResponse> fetchProfessions() async {
    return await _professionRepository.fetchProfessions();
  }

  Future<List<ProfessionDataResponse>> fetchDataProfessions() async {
    return await _professionRepository.fetchDataProfessions();
  }

}