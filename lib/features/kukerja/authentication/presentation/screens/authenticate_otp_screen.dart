import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukerja_web/core/data/models/requests/check_number_request.dart';
import 'package:kukerja_web/core/data/models/requests/login_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_number_response.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/domain/entities/authentication_type.dart';
import 'package:kukerja_web/core/domain/entities/user_type.dart';
import 'package:kukerja_web/core/exceptions/bad_request_exception.dart';
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/providers/authentication_provider.dart';
import 'package:kukerja_web/core/providers/login_info_provider.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/core/widgets/error_dialog.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/small_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../core/config/responsive.dart';
import '../../../../../core/config/size_config.dart';
import '../../../../../core/data/models/responses/login_by_firebase_otp_response.dart';
import '../../../../../core/utils/company_information_util.dart';
import '../../../../../core/widgets/heading_2.dart';
import '../../../../../core/widgets/heading_4.dart';
import '../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../landing_page/style/app_color.dart';
import 'dart:html' as html;
import 'package:kukerja_web/core/domain/entities/user.dart' as EntityUser;

class AuthenticateOtpScreen extends StatefulWidget {
  static const String route = "/authenticate-otp";

  const AuthenticateOtpScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateOtpScreen> createState() => _AuthenticateOtpScreenState();
}

class _AuthenticateOtpScreenState extends State<AuthenticateOtpScreen> {
  final String _phoneNumber = QR.params["phoneNumber"].toString();
  late AuthenticationProvider _authenticationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();

  String? _otpErrorMessage;

  bool _isOtpVerifying = false;

  @override
  void dispose() {
    super.dispose();
    _otp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authenticationProvider = context.watch<AuthenticationProvider>();
    SizeConfig().init(context);

    return Scaffold(
      body: SizedBox(
        child: Row(
          children: [
            if (!ResponsiveWidget.isSmallScreen(context))
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(color: AppColor.primary),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/john-phone.png",
                            fit: BoxFit.fitWidth, width: 320),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Heading2(
                                textColor: Colors.white,
                                text: "Yuk bergabung sebagai Penyedia Kerja",
                              ),
                              const SizedBox(height: 20),
                              RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: CompanyInformationUtil
                                              .secondaryFontFamily),
                                      text: "Bergabung Bersama \n",
                                      children: [
                                    TextSpan(
                                        text: "20000+ ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: "Pekerja Terdaftar \n"),
                                    TextSpan(
                                        text: "GRATIS Buat Lowongan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0, vertical: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Image.asset(
                                      "assets/images/kukerja_logo.png",
                                      fit: BoxFit.fitWidth,
                                      width: 240),
                                ),
                                onTap: () => QR.to("/"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              const Heading4(
                                  text: "Isi OTP", textColor: AppColor.primary),
                              const SizedBox(height: 30),
                              const Text(
                                  "Silahkan masukkan kode OTP yang telah kami kirimkan ke ",
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 30),
                              Form(
                                key: _formKey,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SimpleOutlinedTextInput(
                                          margin: EdgeInsets.zero,
                                          textAlign: TextAlign.center,
                                          maxLength: 6,
                                          controller: _otp,
                                          hintText: "isi otp anda",
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          customValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Mohon kolom ini di isi.";
                                            } else if (_otp.text.length < 6) {
                                              return "panjang OTP tidak sesuai";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                        if (_otpErrorMessage != null)
                                          ShowValidationMessage(
                                              message: _otpErrorMessage!)
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              SmallLoadingButton(
                                text: "Verifikasi",
                                loadingText: "Sedang Verifikasi",
                                isLoading: _isOtpVerifying,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_isOtpVerifying) return;
                                    setState(() => _isOtpVerifying = true);
                                    _otpVerification();
                                  }
                                },
                                buttonSize: const Size.fromHeight(50),
                              ),
                              const SizedBox(height: 80),
                              const Text("Tidak menerima kode?"),
                              TextButton(
                                style: _authenticationProvider.canResendOtp()
                                    ? null
                                    : ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                onPressed:
                                    _authenticationProvider.canResendOtp()
                                        ? () async {
                                            _authenticationProvider
                                                .startOtpCountdown();
                                            await FormUtil
                                                .authFirebaseByPhoneNumber(
                                                    "+$_phoneNumber");
                                          }
                                        : null,
                                child: _authenticationProvider.canResendOtp()
                                    ? const Text("Kirim ulang OTP",
                                        style: TextStyle(
                                            color: AppColor.secondary))
                                    : Text(
                                        "Kirim ulang OTP dalam ${_authenticationProvider.resendOtpCounter} detik",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _otpVerification() async {
    String registeredAs = "";
    _otpErrorMessage = null;

    try {
      String? idToken = await FormUtil.confirmOTP(
          _authenticationProvider.confirmationResult, _otp.text);

      if (_authenticationProvider.authenticationType ==
          AuthenticationType.registration) {
        registeredAs = await _checkRegistrationType();
        if (registeredAs.isNotEmpty) throw BadRequestException(registeredAs);

        RegisByFirebaseOtpRequest regisByFirebaseOtpRequest =
            RegisByFirebaseOtpRequest(
                idToken: idToken!,
                phoneNumber: _authenticationProvider.phoneNumber,
                referralBy: _authenticationProvider.referralBy);

        RegisByFirebaseOtpResponse regisByFirebaseOtpResponse =
            await _authenticationProvider
                .regisByFirebaseOtp(regisByFirebaseOtpRequest);

        if (!mounted) return;
        context
            .read<LoginInfoProvider>()
            .setSignedIn(regisByFirebaseOtpResponse.accessToken);

        if (_authenticationProvider.type == UserType.employer) {
          QR.to("/employers/create");
        } else {
          QR.to("/job-seekers/create");
        }
      } else {
        LoginByFirebaseOtpRequest loginByFirebaseOtpRequest =
            LoginByFirebaseOtpRequest(
                idToken: idToken!,
                phoneNumber: _authenticationProvider.phoneNumber,
                type: _authenticationProvider.type);

        LoginByFirebaseOtpResponse loginByFirebaseOtpResponse =
            await _authenticationProvider
                .loginByFirebaseOtp(loginByFirebaseOtpRequest);

        EntityUser.User user = await _authenticationProvider.fetchProfile();
        await LocalStorageUtil.writeUserName(user.name);

        if (loginByFirebaseOtpResponse.accessToken.isNotEmpty) {
          if (!mounted) return;
          html.window.location.replace("/");
        }
      }

      setState(() => _isOtpVerifying = false);
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-verification-code") {
        setState(() {
          _isOtpVerifying = false;
          _otpErrorMessage = "Kode Otp tidak sesuai";
        });
      }
    } on InternalServerErrorException catch (error) {
      var errorDecoded = jsonDecode(error.message);
      setState(() => _isOtpVerifying = false);
      showDialog(
        context: context,
        builder: (localContext) => ErrorDialog(
          error: errorDecoded["message"],
          onOkPressed: (_) {
            return html.window.location.replace("/sign-in");
          },
        ),
      );
    } on BadRequestException {
      setState(() => _isOtpVerifying = false);
      showDialog(
        context: context,
        builder: (localContext) => ErrorDialog(
          error: registeredAs,
          onOkPressed: (_) {
            return html.window.location.replace("/sign-in");
          },
        ),
      );
    } catch (error) {
      setState(() => _isOtpVerifying = false);
      print(error);
    }
  }

  Future<String> _checkRegistrationType() async {
    late CheckNumberResponse checkNumberResponse;
    String registeredAs = "";

    if (_authenticationProvider.type == UserType.employer) {
      checkNumberResponse = await _authenticationProvider.checkNumber(
          CheckNumberRequest(
              phoneNumber: _authenticationProvider.phoneNumber,
              type: UserType.employer));

      if (checkNumberResponse.isDuplicate && !checkNumberResponse.isSameType) {
        registeredAs = "Nomor anda terdaftar sebagai pencari kerja";
      } else if (checkNumberResponse.isDuplicate &&
          checkNumberResponse.isSameType) {
        registeredAs =
            "Nomor anda telah terdaftar, silahkan sign in sebagai penyedia kerja";
      }
    } else if (_authenticationProvider.type == UserType.jobSeeker) {
      checkNumberResponse = await _authenticationProvider.checkNumber(
          CheckNumberRequest(
              phoneNumber: _authenticationProvider.phoneNumber,
              type: UserType.jobSeeker));

      if (checkNumberResponse.isDuplicate && !checkNumberResponse.isSameType) {
        registeredAs = "Nomor anda terdaftar sebagai penyedia kerja";
      } else if (checkNumberResponse.isDuplicate &&
          checkNumberResponse.isSameType) {
        registeredAs =
            "Nomor anda telah terdaftar, silahkan sign in sebagai pencari kerja";
      }
    }
    return registeredAs;
  }
}
