import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';
import 'package:kukerja_web/core/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class UserUseCase {

  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<void> create(CreateUserRequest createUserRequest) async {
    await _userRepository.create(createUserRequest);
  }

  Future<User> fetchProfile() async => await _userRepository.fetchProfile();

}