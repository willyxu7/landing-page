import 'dart:convert';

import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/job_details_response.dart';
import 'package:http/http.dart' as http;
import 'package:kukerja_web/features/kukerja/recruitment/domain/repositories/job_details_repository.dart';

import '../../../../../env/prod_env.dart';

class JobDetailsRepositoryImpl implements JobDetailsRepository {
  @override
  Future<JobDetailsResponse> getJobDetails(String id) async {
    JobDetailsResponse jobDetailsResponse = JobDetailsResponse();

    var response = await http.get(
        Uri.parse('${ProdEnv.apiURL}/management/jobs/preview/$id'));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var json = responseBody['data'];

      jobDetailsResponse = JobDetailsResponse.fromMap(json);
    } else {
      throw Exception('Failed to load job details');
    }

    return jobDetailsResponse;
  }
}
