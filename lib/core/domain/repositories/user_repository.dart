import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';

import '../entities/user.dart';

abstract class UserRepository {

  Future<void> create(CreateUserRequest createUserRequest);

  Future<User> fetchProfile();

}