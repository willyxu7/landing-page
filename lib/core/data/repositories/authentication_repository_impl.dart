import 'package:kukerja_web/core/data/models/requests/check_company_information_request.dart';
import 'package:kukerja_web/core/data/models/requests/check_number_request.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_company_information_response.dart';
import 'package:kukerja_web/core/data/models/responses/check_number_response.dart';
import 'package:kukerja_web/core/data/models/responses/login_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/domain/repositories/authentication_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';

import '../models/requests/login_by_firebase_otp_request.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<LoginByFirebaseOtpResponse> loginByFirebaseOtp(
      LoginByFirebaseOtpRequest loginByFirebaseOtpRequest) async {
    try {
      var response = await _apiHelper.post(
          "/management/auth/login", loginByFirebaseOtpRequest.toJson(),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });

      return LoginByFirebaseOtpResponse.fromHttpRequest(response["userData"]);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<CheckCompanyInformationResponse> checkCompanyInformation(
      CheckCompanyInformationRequest checkCompanyInformationRequest) async {
    String body = checkCompanyInformationRequest.toJson();

    try {
      var response = await _apiHelper.post(
          '/management/auth/check-is-duplicate', body, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      return CheckCompanyInformationResponse.fromJson(response);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<CheckNumberResponse> checkNumber(
      CheckNumberRequest checkNumberRequest) async {
    try {
      var response = await _apiHelper.post(
          "/management/auth/checknumber", checkNumberRequest.toJson(),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });

      return CheckNumberResponse.fromHttpRequest(response);
    } on AppException {
      rethrow;
    }
  }

  @override
  Future<RegisByFirebaseOtpResponse> regisByFirebaseOtp(
      RegisByFirebaseOtpRequest request) async {
    try {
      var response = await _apiHelper.post(
          "/management/auth/register", request.toJson(), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      RegisByFirebaseOtpResponse regisByFirebaseOtpResponse =
          RegisByFirebaseOtpResponse.fromMap(response["userData"]);

      await LocalStorageUtil.writeAccessToken(
          regisByFirebaseOtpResponse.accessToken);
      await LocalStorageUtil.writeId(regisByFirebaseOtpResponse.id);
      await LocalStorageUtil.writePhoneNumber(
          regisByFirebaseOtpResponse.phoneNumber);

      return regisByFirebaseOtpResponse;
    } on AppException catch (_) {
      rethrow;
    }
  }
}
