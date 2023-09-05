import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../core/config/responsive.dart';
import '../../../../../core/config/size_config.dart';
import '../../../../../core/domain/entities/authentication_type.dart';
import '../../../../../core/domain/entities/user_type.dart';
import '../../../../../core/providers/authentication_provider.dart';
import '../../../../../core/utils/company_information_util.dart';
import '../../../../../core/utils/form_util.dart';
import '../../../../../core/widgets/error_dialog.dart';
import '../../../../../core/widgets/heading_2.dart';
import '../../../../../core/widgets/heading_4.dart';
import '../../../../../core/widgets/secondary_text_button.dart';
import '../../../../../core/widgets/simple_outlined_number_input.dart';
import '../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../core/widgets/small_button.dart';
import '../../../landing_page/style/app_color.dart';

class RegistrationJobSeekerScreen extends StatefulWidget {
  static const String route = "job-seeker";

  const RegistrationJobSeekerScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationJobSeekerScreen> createState() =>
      _RegistrationJobSeekerScreenState();
}

class _RegistrationJobSeekerScreenState
    extends State<RegistrationJobSeekerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isReferralCode = false;
  String _phoneCountryCode = "+62";

  late AuthenticationProvider _authenticationProvider;


  final TextEditingController _phoneNumber = TextEditingController(),
      _referralCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authenticationProvider = context.watch<AuthenticationProvider>();

    SizeConfig().init(context);

    return Scaffold(
      body: SizedBox(
        child: Row(
          children: [
            if(!ResponsiveWidget.isSmallScreen(context)) Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(color: AppColor.primary),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/ray-phone.png",
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
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: "Pekerja Terdaftar \n"),
                                      TextSpan(text: "dan Lebih dari \n"),
                                      TextSpan(
                                          text: "1800+ ",
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: "Lowongan Kerja Tersedia"),
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Heading4(
                                    text: "Daftar Pencari Kerja",
                                    textColor: AppColor.primary),
                                const SizedBox(height: 60),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Nomor Handphone"),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex:
                                                  ResponsiveWidget.isSmallScreen(
                                                          context)
                                                      ? 2
                                                      : 1,
                                              child: SizedBox(
                                                height: 60,
                                                child: CountryCodePicker(
                                                  onChanged: (countryCode) =>
                                                      setState(() {
                                                    _phoneCountryCode =
                                                        countryCode.toString();
                                                  }),
                                                  initialSelection: 'id',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: SimpleOutlinedNumberInput(
                                                margin: EdgeInsets.zero,
                                                controller: _phoneNumber,
                                                hintText: 'contoh: 89876543211',
                                                customValidator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
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
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SecondaryTextButton(
                                            text: "Punya kode referral?",
                                            onPressed: () => setState(() =>
                                                _isReferralCode =
                                                    !_isReferralCode))
                                      ],
                                    ))
                                  ],
                                ),
                                if (_isReferralCode) _showReferralCodeInput(),
                                const SizedBox(height: 60),
                                SmallButton(
                                  text: "Daftar Sebagai Pencari Kerja",
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      _regisByFirebaseOtp();
                                    }
                                  },
                                  buttonSize: const Size.fromHeight(50),
                                ),
                                const SizedBox(height: 80),
                                const Text("Sudah mempunyai akun?"),
                                SecondaryTextButton(
                                    text: "Masuk ke akun",
                                    onPressed: () =>
                                        QR.to("/sign-in/job-seeker"))
                              ],
                            ),
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

  Widget _showReferralCodeInput() {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Kode Referral"),
            SimpleOutlinedTextInput(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                ],
                maxLength: 8,
                optional: true,
                controller: _referralCode,
                hintText: "masukkan kode referral (jika ada)")
          ],
        )),
      ],
    );
  }

  void _regisByFirebaseOtp() async {
    String phoneNumber = _phoneCountryCode +
        FormUtil.removeFirstZeroPhoneNumber(_phoneNumber.text);

    try {
      var confirmationResult =
      await FormUtil.authFirebaseByPhoneNumber(phoneNumber);
      _authenticationProvider
        ..confirmationResult = confirmationResult
        ..phoneNumber = phoneNumber
        ..type = UserType.jobSeeker
        ..referralBy = _referralCode.text
        ..authenticationType = AuthenticationType.registration;

      if (!mounted) return;
      QR.to("/authenticate-otp/${phoneNumber.substring(1)}");
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
}
