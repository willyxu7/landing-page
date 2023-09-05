import 'package:kukerja_web/core/domain/repositories/education_repository.dart';

import '../../data/models/responses/education_response.dart';

class EducationUseCase {
  final EducationRepository _educationRepository;

  EducationUseCase(this._educationRepository);

  Future<EducationResponse> fetchEducations() async {
    return await _educationRepository.fetchEducations();
  }

}