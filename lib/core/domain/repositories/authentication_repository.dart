import 'package:kukerja_web/core/data/models/requests/check_company_information_request.dart';
import 'package:kukerja_web/core/data/models/requests/check_number_request.dart';
import 'package:kukerja_web/core/data/models/requests/login_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_company_information_response.dart';
import 'package:kukerja_web/core/data/models/responses/check_number_response.dart';
import 'package:kukerja_web/core/data/models/responses/login_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';

abstract class AuthenticationRepository {
  Future<LoginByFirebaseOtpResponse> loginByFirebaseOtp(LoginByFirebaseOtpRequest loginByFirebaseOtpRequest);

  Future<CheckCompanyInformationResponse> checkCompanyInformation(
      CheckCompanyInformationRequest checkCompanyInformationRequest);

  Future<CheckNumberResponse> checkNumber(CheckNumberRequest checkNumberRequest);

  Future<RegisByFirebaseOtpResponse> regisByFirebaseOtp(RegisByFirebaseOtpRequest request);

}
