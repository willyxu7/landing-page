import 'package:kukerja_web/core/domain/repositories/education_level_repository.dart';

import '../../data/models/responses/education_level_response.dart';

class EducationLevelUseCase {
  final EducationLevelRepository _educationLevelRepository;

  EducationLevelUseCase(this._educationLevelRepository);

  Future<EducationLevelResponse> fetchEducationLevels()async {
    return await _educationLevelRepository.fetchEducationLevels();
  }

}