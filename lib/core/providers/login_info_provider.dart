import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';

class LoginInfoProvider with ChangeNotifier {
  String? accessToken;

  bool get signedIn => accessToken != null;

  void setSignedIn(String accessToken) {
    accessToken = accessToken;
    notifyListeners();
  }

  Future<void> initSignInInfo() async {
    accessToken = await LocalStorageUtil.readAccessToken();

    notifyListeners();
  }

}