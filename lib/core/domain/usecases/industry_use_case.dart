import 'package:kukerja_web/core/data/models/responses/industry_response.dart';
import 'package:kukerja_web/core/domain/repositories/industry_repository.dart';

class IndustryUseCase {
  final IndustryRepository _industryRepository;

  IndustryUseCase(this._industryRepository);

  Future<IndustryResponse> fetchIndustries() async {
    return await _industryRepository.fetchIndustries();
  }

}