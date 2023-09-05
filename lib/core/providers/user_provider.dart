import 'package:flutter/cupertino.dart';
import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';

class UserProvider with ChangeNotifier {

  late CreateUserRequest _createUserRequest;

  CreateUserRequest get createUserRequest => _createUserRequest;

  set createUserRequest(CreateUserRequest createUserRequest) {
    _createUserRequest = createUserRequest;
    notifyListeners();
  }

}