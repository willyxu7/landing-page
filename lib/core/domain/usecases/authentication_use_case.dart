import 'package:kukerja_web/core/data/models/requests/check_company_information_request.dart';
import 'package:kukerja_web/core/data/models/requests/check_number_request.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_company_information_response.dart';
import 'package:kukerja_web/core/data/models/responses/check_number_response.dart';
import 'package:kukerja_web/core/data/models/responses/login_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/domain/repositories/authentication_repository.dart';

import '../../data/models/requests/login_by_firebase_otp_request.dart';
import '../../utils/local_storage_util.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationUseCase(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository;

  Future<LoginByFirebaseOtpResponse> loginByFirebaseOtp(
      LoginByFirebaseOtpRequest loginByFirebaseOtpRequest) async {
    LoginByFirebaseOtpResponse loginByFirebaseOtpResponse =
        await _authenticationRepository
            .loginByFirebaseOtp(loginByFirebaseOtpRequest);

    await LocalStorageUtil.writeAccessToken(
        loginByFirebaseOtpResponse.accessToken);
    await LocalStorageUtil.writeId(loginByFirebaseOtpResponse.userId);
    await LocalStorageUtil.writePhoneNumber(
        loginByFirebaseOtpResponse.phoneNumber);

    return loginByFirebaseOtpResponse;
  }

  Future<CheckCompanyInformationResponse> checkCompanyInformation(
      CheckCompanyInformationRequest checkCompanyInformationRequest) async {
    return await _authenticationRepository
        .checkCompanyInformation(checkCompanyInformationRequest);
  }

  Future<CheckNumberResponse> checkNumber(
          CheckNumberRequest checkNumberRequest) async =>
      await _authenticationRepository.checkNumber(checkNumberRequest);

  Future<RegisByFirebaseOtpResponse> regisByFirebaseOtp(
      RegisByFirebaseOtpRequest request) async {
    return await _authenticationRepository.regisByFirebaseOtp(request);
  }
}
