import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/data/models/requests/check_company_information_request.dart';
import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';
import 'package:kukerja_web/core/data/models/responses/check_company_information_response.dart';
import 'package:kukerja_web/core/data/repositories/authentication_repository_impl.dart';
import 'package:kukerja_web/core/domain/usecases/authentication_use_case.dart';
import 'package:kukerja_web/core/providers/user_provider.dart';
import 'package:kukerja_web/core/widgets/heading_2.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_input.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/providers/freetalent_employer_provider.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/items/freetalent_employer_form_desktop_widget.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/items/freetalent_employer_form_mobile_widget.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../../core/config/size_config.dart';
import '../../../../../../core/providers/city_provider.dart';
import '../../../../../../core/widgets/heading_3.dart';
import '../../../../../../core/widgets/paragraph_widget.dart';
import '../../../../../../core/widgets/simple_outlined_dropdown_search.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../landing_page/style/app_color.dart';

class FreetalentEmployerFormWidget extends StatefulWidget {
  const FreetalentEmployerFormWidget({Key? key}) : super(key: key);

  @override
  State<FreetalentEmployerFormWidget> createState() =>
      _FreetalentEmployerFormWidgetState();
}

class _FreetalentEmployerFormWidgetState
    extends State<FreetalentEmployerFormWidget> {
  final AuthenticationUseCase _authenticationUseCase =
      AuthenticationUseCase(AuthenticationRepositoryImpl());

  late CheckCompanyInformationResponse _checkCompanyInformationResponse;

  final GlobalKey<FormState> _freetalentEmpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _userRegisterFormKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _workingDaysController = TextEditingController();
  final TextEditingController _workingTimeController = TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();
  final TextEditingController _scheduleNoteController = TextEditingController();
  final TextEditingController _startWorkingHourController =
      TextEditingController();
  final TextEditingController _endWorkingHourController =
      TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _phoneCountryCode = '+62';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return PageView(
      // controller: _pageController,
      controller: context.read<FreetalentEmployerProvider>().pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: SizedBox(
            width: 640,
            child: Form(
              key: _userRegisterFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Heading2(text: 'Informasi Perusahaan'),
                    const SizedBox(height: 16),
                    const Text('Nama Usaha'),
                    SimpleOutlinedTextInput(
                      controller: _companyNameController,
                      hintText: 'masukkan nama usaha anda',
                      customValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon kolom ini di isi.';
                        } else if (_checkCompanyInformationResponse
                            .isCompanyNameDuplicate) {
                          return 'Nama usaha telah terdaftar';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Text('Nomor Handphone'),
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
                          child: SimpleOutlinedTextInput(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _phoneNumberController,
                            hintText: 'contoh: 89876543211',
                            customValidator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mohon kolom ini di isi.';
                              } else if (_checkCompanyInformationResponse
                                  .isPhoneNumberDuplicate) {
                                return 'Nomor handphone telah terdaftar';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    const Text('Email'),
                    SimpleOutlinedTextInput(
                        controller: _emailController,
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon kolom ini di isi.';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Email tidak valid';
                          } else if (_checkCompanyInformationResponse
                              .isEmailDuplicate) {
                            return 'Email telah terdaftar';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'masukkan email'),
                    const Text('Kota'),
                    SimpleOutlinedDropdownSearch<String>(
                        hintText: 'pilih lokasi kota',
                        items: context.watch<CityProvider>().cities,
                        onChanged: (city) {
                          context.read<CityProvider>().selectedLocation =
                              city.toString();
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: SmallButton(
                          text: 'Selanjutnya',
                          onPressed: () async {
                            if (_companyNameController.text.isNotEmpty &&
                                _phoneNumberController.text.isNotEmpty &&
                                _emailController.text.isNotEmpty) {
                              await _checkCompanyInformation();
                            }

                            if (_userRegisterFormKey.currentState!.validate()) {
                              _holdUserInformation();

                              // _pageController.nextPage(
                              //     duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                              context
                                  .read<FreetalentEmployerProvider>()
                                  .pageController
                                  .nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveWidget.isSmallScreen(context)
                    ? FreetalentEmployerFormMobileWidget(
                        addressController: _addressController,
                        descriptionController: _descriptionController,
                        workingDaysController: _workingDaysController,
                        workingTimeController: _workingTimeController,
                        workingHoursController: _workingHoursController,
                        scheduleNoteController: _scheduleNoteController,
                        startWorkingHourController: _startWorkingHourController,
                        endWorkingHourController: _endWorkingHourController,
                        formKey: _freetalentEmpFormKey)
                    : FreetalentEmployerFormDesktopWidget(
                        addressController: _addressController,
                        descriptionController: _descriptionController,
                        workingDaysController: _workingDaysController,
                        workingTimeController: _workingTimeController,
                        workingHoursController: _workingHoursController,
                        scheduleNoteController: _scheduleNoteController,
                        startWorkingHourController: _startWorkingHourController,
                        endWorkingHourController: _endWorkingHourController,
                        formKey: _freetalentEmpFormKey)
              ],
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/thumbs-up.png',
                width: 400,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              const SizedBox(
                height: 24,
              ),
              const Heading3(
                text: 'Pengajuan freetalent anda telah berhasil',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              ParagraphWidget(
                'Terima kasih telah mengajukan freetalent. Pengajuan anda akan kami tinjau dan validasi',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    primary: AppColor.primary,
                    textStyle: const TextStyle(fontSize: 16)),
                onPressed: () {
                  QR.to('/freetalents-emp');
                },
                child: const Text('Kembali ke home'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _checkCompanyInformation() async {
    CheckCompanyInformationRequest checkCompanyInformationRequest =
        CheckCompanyInformationRequest(
            companyName: _companyNameController.text,
            phoneNumber: _phoneCountryCode + _phoneNumberController.text,
            email: _emailController.text);

    CheckCompanyInformationResponse companyInformationResponse =
        await _authenticationUseCase
            .checkCompanyInformation(checkCompanyInformationRequest);

    setState(() {
      _checkCompanyInformationResponse = companyInformationResponse;
    });
  }

  void _holdUserInformation() {
    context.read<UserProvider>().createUserRequest = CreateUserRequest()
      ..name = _companyNameController.text
      ..email = _emailController.text
      ..phoneCountryCode = _phoneCountryCode
      ..phoneNumber = _phoneNumberController.text
      ..city = context.read<CityProvider>().selectedLocation;
  }
}
