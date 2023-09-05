import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/data/models/responses/regis_by_firebase_otp_response.dart';
import 'package:kukerja_web/core/domain/entities/user.dart' as EntityUser;
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/heading_3.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_area.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_input.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/create_employer_information_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/providers/sultan_recruitment_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/responsive.dart';
import '../../../../../../core/utils/form_util.dart';
import '../../../../../../core/widgets/error_dialog.dart';
import '../../../../../../core/widgets/simple_outlined_dropdown_search.dart';
import '../../../../../../core/widgets/simple_outlined_number_input.dart';
import '../../../../landing_page/style/app_color.dart';
import '../../../../talent_pool/presentation/widgets/items/talent_pool_otp_dialog.dart';

class EmployerInformationFormDesktop extends StatefulWidget {
  const EmployerInformationFormDesktop({Key? key}) : super(key: key);

  @override
  State<EmployerInformationFormDesktop> createState() =>
      _EmployerInformationFormDesktopState();
}

class _EmployerInformationFormDesktopState
    extends State<EmployerInformationFormDesktop> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController(),
      _companyAddressController = TextEditingController(),
      _phoneNumberController = TextEditingController(),
      _referralController = TextEditingController(),
      _emailController = TextEditingController();

  bool _isOtpLoading = false;

  late SultanRecruitmentProvider _sultanRecruitmentProvider;

  String _phoneCountryCode = "+62", _city = "", _industry = "";

  @override
  Widget build(BuildContext context) {
    _sultanRecruitmentProvider = context.watch<SultanRecruitmentProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Heading3(
                text: "Rekrut ala Sultan",
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama Usaha"),
                    SimpleOutlinedTextInput(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z_ ]")),
                        ],
                        maxLength: 120,
                        controller: _companyNameController,
                        hintText: "masukkan nama usaha anda")
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email'),
                    SimpleOutlinedTextInput(
                        maxLength: 120,
                        controller: _emailController,
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon kolom ini di isi.';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Email tidak valid';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'masukkan email'),
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat Usaha"),
                    SimpleOutlinedTextArea(
                        maxLength: 255,
                        controller: _companyAddressController,
                        hintText: "masukkan alamat usaha anda")
                  ],
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("No Handphone"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: ResponsiveWidget.isSmallScreen(context) ? 2 : 1,
                          child: SizedBox(
                            height: 60,
                            child: CountryCodePicker(
                              onChanged: (countryCode) => setState(() {
                                _phoneCountryCode = countryCode.toString();
                              }),
                              initialSelection: 'id',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SimpleOutlinedNumberInput(
                            maxLength: 15,
                            controller: _phoneNumberController,
                            hintText: 'contoh: 89876543211',
                            customValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mohon kolom ini di isi.';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Kota"),
                    SimpleOutlinedDropdownSearch(
                        items: _sultanRecruitmentProvider.cities,
                        hintText: "pilih kota",
                        onChanged: (String selectedCity) {
                          _city = selectedCity;
                        })
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Industri"),
                    SimpleOutlinedDropdownSearch(
                        items: _sultanRecruitmentProvider.industries,
                        hintText: "pilih industri",
                        onChanged: (String selectedCity) {
                          _industry = selectedCity;
                        })
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Kode referral"),
                      SimpleOutlinedTextInput(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9]")),
                          ],
                          maxLength: 8,
                          optional: true,
                          controller: _referralController,
                          hintText: "masukkan kode referral (jika ada)")
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColor.secondary),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _confirmInformation();
                    } else {
                      FormUtil.showToast(context);
                    }
                  },
                  child: const Text(
                    "Konfirmasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _confirmInformation() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (_phoneNumberController.text.startsWith('0')) {
      _phoneNumberController.text = _phoneNumberController.text.substring(1);
    }

    final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();
    String? otpErrorMessage;

    try {
      var confirmationResult = await auth.signInWithPhoneNumber(
          _phoneCountryCode + _phoneNumberController.text,
          RecaptchaVerifier(
              onError: (error) => print("Error"),
              onExpired: () => print("expired")));

      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return StatefulBuilder(builder: (context, state) {
              return OtpDialog(
                errorMessage: otpErrorMessage,
                phoneNumber: _phoneCountryCode + _phoneNumberController.text,
                otpFormKey: otpFormKey,
                otpController: otpController,
                isLoading:
                    context.watch<SultanRecruitmentProvider>().isOtpLoading,
                otpCounter:
                    context.watch<SultanRecruitmentProvider>().resendOtpCounter,
                canResendOtp:
                    context.watch<SultanRecruitmentProvider>().canResendOtp(),
                onSubmitted: () async {
                  if (otpFormKey.currentState!.validate()) {
                    if (context
                        .read<SultanRecruitmentProvider>()
                        .isOtpLoading) {
                      return;
                    }

                    state(() => context
                        .read<SultanRecruitmentProvider>()
                        .isOtpLoading = true);
                    try {
                      String? idToken = await FormUtil.confirmOTP(
                          confirmationResult, otpController.text);

                      _regisByFirebaseOtp(idToken!);
                    } on FirebaseAuthException catch (error) {
                      if (error.code == "invalid-verification-code") {
                        state(() {
                          otpErrorMessage = "Kode OTP tidak sesuai";
                          context
                              .read<SultanRecruitmentProvider>()
                              .isOtpLoading = false;
                        });
                      }
                    } catch (e) {
                      rethrow;
                    }
                  }
                },
                onResendOtp: () async {
                  _sultanRecruitmentProvider.startOtpCountdown();
                  try {
                    await auth.signInWithPhoneNumber(
                        _phoneCountryCode + _phoneNumberController.text);
                    state(() => context
                        .read<SultanRecruitmentProvider>()
                        .isOtpLoading = false);

                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webResendOtp,
                        extra: ActivityExtraRequest(
                            state: "tap",
                            screen: "sultan recruitment",
                            widget: "resend otp")));
                  } catch (_) {
                    rethrow;
                  }
                },
                onClosed: () {
                  state(() {
                    context.read<SultanRecruitmentProvider>().isOtpLoading =
                        false;
                    otpController.text = "";
                  });
                  Navigator.pop(context);
                },
              );
            });
          });
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-phone-number") {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                error: "Nomor handphone tidak valid",
                onOkPressed: (_) {
                  Navigator.of(context).pop();
                },
              );
            });
      } else if (error.code == "too-many-requests") {
        PostActivityUseCase.exec(ActivityRequest(
            type: ActivityTypeUtil.webTooManyRequestOtp,
            extra: ActivityExtraRequest(screen: "sultan recruitment")));
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                error: "Coba lagi beberapa saat",
                onOkPressed: (_) {
                  Navigator.of(context).pop();
                },
              );
            });
      }
    } catch (error) {
      print(error);
    }
  }

  void _regisByFirebaseOtp(String idToken) async {
    RegisByFirebaseOtpRequest regisRequest = RegisByFirebaseOtpRequest(
        idToken: idToken,
        phoneNumber: _phoneCountryCode + _phoneNumberController.text,
        referralBy: _referralController.text);

    try {
      RegisByFirebaseOtpResponse regisResponse =
          await _sultanRecruitmentProvider.regisByFirebaseOtp(regisRequest);

      EntityUser.User user = await _sultanRecruitmentProvider.fetchProfile();

      if (user.name.isNotEmpty) {
        if (!mounted) return;
        Navigator.pop(context);
        _sultanRecruitmentProvider.pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        CreateEmployerInformationRequest employerInformationRequest =
            CreateEmployerInformationRequest(
                type: "Employer",
                companyName: _companyNameController.text,
                companyEmail: _emailController.text,
                companyAddress: _companyAddressController.text,
                phoneNumber: _phoneCountryCode + _phoneNumberController.text,
                city: _city,
                industry: _industry);

        _sultanRecruitmentProvider
            .confirmInformation(employerInformationRequest)
            .then((response) {
          _sultanRecruitmentProvider.selectedCity = _city;

          PostActivityUseCase.exec(ActivityRequest(
              type: ActivityTypeUtil.webSultanRecruitmentSuccessRegis,
              extra: ActivityExtraRequest(
                  state: "tap",
                  screen: "sultan recruitment",
                  widget: "konfirmasi")));

          Navigator.pop(context);
          if (response.id.isNotEmpty) {
            _sultanRecruitmentProvider.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }
        });
      }
    } on InternalServerErrorException catch (error) {
      return showDialog<Null>(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, state) {
              String errorMessage = error.toString();
              if (error
                  .toString()
                  .contains("Phone number has already been used")) {
                errorMessage = "Nomor anda telah terdaftar";
              }
              return ErrorDialog(
                error: errorMessage,
                onOkPressed: (loading) {
                  context.read<SultanRecruitmentProvider>().isOtpLoading =
                      false;
                  Navigator.of(context).pop();
                },
              );
            });
          });
    } catch (_) {}
  }
}
