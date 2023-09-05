import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:kukerja_web/core/data/models/requests/check_number_request.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_number_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/data/repositories/authentication_repository_impl.dart';
import 'package:kukerja_web/core/data/repositories/user_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/authentication_type.dart';
import 'package:kukerja_web/core/domain/usecases/authentication_use_case.dart';
import 'package:kukerja_web/core/domain/usecases/user_use_case.dart';
import 'package:kukerja_web/core/domain/entities/user.dart' as EntityUser;

import '../data/models/requests/login_by_firebase_otp_request.dart';
import '../data/models/responses/login_by_firebase_otp_response.dart';

class AuthenticationProvider with ChangeNotifier {
  // Variable Section

  final AuthenticationUseCase _authenticationUseCase =
      AuthenticationUseCase(AuthenticationRepositoryImpl());
  final UserUseCase _userUseCase = UserUseCase(UserRepositoryImpl());

  int baseOtpCounter = 60;
  int resendOtpCounter = 60;

  late ConfirmationResult confirmationResult;
  late String phoneNumber, type, referralBy;
  late AuthenticationType authenticationType;

  // End Variable Section

  // Method Section

  Future<LoginByFirebaseOtpResponse> loginByFirebaseOtp(
      LoginByFirebaseOtpRequest loginByFirebaseOtpRequest) async {
    return await _authenticationUseCase
        .loginByFirebaseOtp(loginByFirebaseOtpRequest);
  }

  Future<RegisByFirebaseOtpResponse> regisByFirebaseOtp(
      RegisByFirebaseOtpRequest request) async {
    return await _authenticationUseCase.regisByFirebaseOtp(request);
  }

  Future<CheckNumberResponse> checkNumber(
          CheckNumberRequest checkNumberRequest) async =>
      await _authenticationUseCase.checkNumber(checkNumberRequest);

  Future<EntityUser.User> fetchProfile() async {
    return await _userUseCase.fetchProfile();
  }

  void startOtpCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      resendOtpCounter--;
      notifyListeners();

      if (resendOtpCounter == 0) {
        resendOtpCounter = 60;
        timer.cancel();
      }
    });
  }

  bool canResendOtp() {
    return resendOtpCounter == baseOtpCounter;
  }

// End Method Section
}
