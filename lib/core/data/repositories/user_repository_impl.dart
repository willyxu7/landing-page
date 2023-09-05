import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';
import 'package:kukerja_web/core/data/models/responses/user_response.dart';
import 'package:kukerja_web/core/domain/entities/user.dart';
import 'package:kukerja_web/core/domain/repositories/user_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class UserRepositoryImpl implements UserRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<void> create(CreateUserRequest createUserRequest) async {
    try {} on AppException {
      rethrow;
    }
  }

  @override
  Future<User> fetchProfile() async {
    try {
      var response = await _apiHelper.get("/management/users/profile");

      return UserResponse.mapUserResponseToUser(
          UserResponse.fromHttpRequest(response));
    } on AppException {
      rethrow;
    }
  }
}
