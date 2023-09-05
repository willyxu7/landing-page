// import 'dart:convert';

// import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employer_response.dart';
// import 'package:kukerja_web/features/kukerja/profile/domain/repositories/profile_employer_repository.dart';
// import 'package:http/http.dart' as http;

// import '../../../../../env/prod_env.dart';

// class ProfileEmployerRepositoryImpl implements ProfileEmployerRepository {
//   @override
//   Future<ProfileEmployerResponse> getProfileEmployer(String id) async {
//     ProfileEmployerResponse profileEmployerResponse = ProfileEmployerResponse();

//     var response = await http.get(
//         Uri.parse(ActivityEnv.apiURLTest + '/management/jobs/preview/$id'));

//     if (response.statusCode == 200) {
//       var responseBody = jsonDecode(response.body);
//       var json = responseBody['data'];

//       profileEmployerResponse = ProfileEmployerResponse.fromMap(json);
//     } else {
//       throw Exception('Failed to load job details');
//     }

//     return profileEmployerResponse;
//   }
// }
