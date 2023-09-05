import 'package:kukerja_web/core/data/models/responses/education_level_response.dart';

abstract class EducationLevelRepository {
  Future<EducationLevelResponse> fetchEducationLevels();
}