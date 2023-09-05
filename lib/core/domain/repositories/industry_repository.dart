import 'package:kukerja_web/core/data/models/responses/industry_response.dart';

abstract class IndustryRepository {
  Future<IndustryResponse> fetchIndustries();
}