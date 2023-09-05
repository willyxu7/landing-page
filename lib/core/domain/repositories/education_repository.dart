import '../../data/models/responses/education_response.dart';

abstract class EducationRepository {
  Future<EducationResponse> fetchEducations();
}