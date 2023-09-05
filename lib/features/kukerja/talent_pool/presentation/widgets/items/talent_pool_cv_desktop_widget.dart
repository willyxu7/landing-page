import 'dart:async';
import 'dart:typed_data';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/data/models/requests/regis_by_firebase_otp_request.dart';
import 'package:kukerja_web/core/domain/entities/user.dart' as entity_user;
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/widgets/error_dialog.dart';
import 'package:kukerja_web/core/widgets/heading_3.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_number_input.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_picker_input.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_input.dart';
import 'package:kukerja_web/core/widgets/small_text_button.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_experience_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_cv_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_information.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_non_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/experience_dialog.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/experience_information.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/talent_pool_otp_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/config/responsive.dart';
import '../../../../../../core/utils/date_picker_util.dart';
import '../../../../../../core/widgets/small_text_icon_button.dart';
import '../../../data/models/responses/talent_pool_cv_response.dart';

class TalentPoolCVDesktopWidget extends StatefulWidget {
  const TalentPoolCVDesktopWidget({Key? key}) : super(key: key);

  @override
  State<TalentPoolCVDesktopWidget> createState() =>
      _TalentPoolCVDesktopWidgetState();
}

class _TalentPoolCVDesktopWidgetState extends State<TalentPoolCVDesktopWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(),
      _phoneNumberController = TextEditingController(),
      _companyNameController = TextEditingController(),
      _birthDateController = TextEditingController(),
      _positionController = TextEditingController(),
      _referralController = TextEditingController(),
      _emailController = TextEditingController();

  static const double _space = 20;

  String _selectedGender = "",
      _selectedMarriedStatus = "",
      _selectedReligion = "",
      _selectedCity = "",
      _selectedIndustry = "",
      _selectedStartYear = "",
      _phoneCountryCode = "+62";

  bool _isStillWorking = false;
  late TalentPoolProvider _talentPoolProvider;

  final FilePicker _filePicker = FilePicker.platform;

  final TextEditingController _otpController = TextEditingController();

  Uint8List? _uploadedPasPhoto;

  String? _pasPhotoErrorMessage, _otpErrorMessage, _educationFormalErrorMessage;

  DateTime? selectedBirthDate;

  @override
  void initState() {
    super.initState();

    PostActivityUseCase.exec(
        ActivityRequest(type: ActivityTypeUtil.webViewTalentPoolForm));
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _phoneNumberController.dispose();
    _companyNameController.dispose();
    _birthDateController.dispose();
    _positionController.dispose();
    _referralController.dispose();
    _emailController.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _talentPoolProvider = context.watch<TalentPoolProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Heading3(text: "Talent Pool CV"),
            ),
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Pas Foto"),
                        if (_uploadedPasPhoto != null)
                          Image.memory(
                            _uploadedPasPhoto!,
                            width: double.infinity,
                            height: 200,
                          ),
                        const SizedBox(height: 10),
                        SmallTextIconButton.square(
                            text: "Upload pas foto",
                            onPressed: () async {
                              var pasPhoto = await _filePicker.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'jpeg', 'png']);

                              if (pasPhoto != null) {
                                setState(() {
                                  _uploadedPasPhoto =
                                      pasPhoto.files.first.bytes;
                                });
                              }
                            },
                            icon: FontAwesomeIcons.paperclip),
                        if (_pasPhotoErrorMessage != null)
                          ShowValidationMessage(message: _pasPhotoErrorMessage!)
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: _space),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama"),
                    SimpleOutlinedTextInput(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z_ ]")),
                        ],
                        maxLength: 120,
                        controller: _nameController,
                        hintText: "masukkan nama anda")
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email'),
                    SimpleOutlinedTextInput(
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
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Jenis Kelamin"),
                    SimpleOutlinedDropdownSearch(
                        showSearchBox: false,
                        items: const ["Pria", "Wanita"],
                        hintText: "pilih jenis kelamin",
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        })
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Status Pernikahan"),
                    SimpleOutlinedDropdownSearch(
                        showSearchBox: false,
                        items: const ["Belum Menikah", "Menikah"],
                        hintText: "pilih status pernikahan",
                        onChanged: (value) {
                          setState(() {
                            _selectedMarriedStatus = value;
                          });
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
                    const Text("Agama"),
                    SimpleOutlinedDropdownSearch(
                        showSearchBox: false,
                        items: _talentPoolProvider.religions,
                        hintText: "pilih agama",
                        onChanged: (value) {
                          setState(() {
                            _selectedReligion = value;
                          });
                        })
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tanggal Lahir"),
                    SimpleOutlinedPickerInput(
                        readOnly: true,
                        controller: _birthDateController,
                        hintText: "pilih tanggal lahir",
                        onTap: () async {
                          selectedBirthDate =
                              await DatePickerUtil.datePicker(context);

                          if (selectedBirthDate != null) {
                            setState(() {
                              _birthDateController.text =
                                  DateFormat.yMMMMd('idr')
                                      .format(selectedBirthDate!);
                            });
                          }
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
                    const Text("Kota Tinggal"),
                    SimpleOutlinedDropdownSearch(
                        hintText: "pilih kota tinggal",
                        items: _talentPoolProvider.cities,
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        })
                    // SimpleOutlinedDropdownButton(
                    //     items: _talentPoolProvider.cities,
                    //     hint: "pilih kota",
                    //     onChanged: (value) {
                    //       print(value);
                    //     })
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Minat Industri"),
                    SimpleOutlinedDropdownSearch(
                        hintText: "pilih minat industri",
                        items: _talentPoolProvider.industries,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndustry = value;
                          });
                        })
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        ListTile(
                            title: const Text("Pendidikan Formal"),
                            subtitle: _educationFormalErrorMessage != null
                                ? ShowValidationMessage(
                                    message: _educationFormalErrorMessage!)
                                : const SizedBox.shrink(),
                            trailing: SmallTextButton.square(
                                text: "+ Tambah Pendidikan",
                                onPress: () {
                                  _openEducationFormalDialog(context);
                                })),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        ..._buildEducationFormalInformation(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        ListTile(
                            title: const Text("Pendidikan Non Formal"),
                            subtitle: const SizedBox.shrink(),
                            trailing: SmallTextButton.square(
                                text: "+ Tambah Pendidikan",
                                onPress: () {
                                  _openEducationNonFormalDialog(context);
                                })),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        ..._buildEducationNonFormalInformation(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        ListTile(
                            title: const Text("Pengalaman Kerja"),
                            subtitle: const Text("Isi pengalaman terbaikmu"),
                            trailing: SmallTextButton.square(
                                text: "+ Tambah Pengalaman",
                                onPress: () {
                                  _openExperienceDialog(context);
                                })),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        ..._buildExperienceInformation(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColor.secondary,
              title: const Text("Sedang Bekerja?"),
              value: _isStillWorking,
              onChanged: (value) {
                setState(() {
                  if (_isStillWorking) {
                    _clearIsStillWorkingFormData();
                  }
                  _isStillWorking = value!;
                });
              },
            ),
            if (_isStillWorking) _showStillWorkingForm(),
            const SizedBox(height: 10),
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
                    setState(() {
                      _validatePasPhoto();
                      _validateEducationFormal();
                    });
                    if (_formKey.currentState!.validate() &&
                        _uploadedPasPhoto != null &&
                        _educationFormalErrorMessage == null) {
                      PostActivityUseCase.exec(ActivityRequest(
                          type: ActivityTypeUtil.webSaveCv,
                          extra: ActivityExtraRequest(
                              state: "tap",
                              widget: "button",
                              screen: "talent pool")));

                      _saveCV();
                    } else {
                      FormUtil.showToast(context);
                    }
                  },
                  child: const Text(
                    "Simpan Data",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _saveCV() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (_phoneNumberController.text.startsWith('0')) {
      _phoneNumberController.text = _phoneNumberController.text.substring(1);
    }

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
                errorMessage: _otpErrorMessage,
                phoneNumber: _phoneCountryCode + _phoneNumberController.text,
                otpFormKey: _otpFormKey,
                otpController: _otpController,
                isLoading: context.watch<TalentPoolProvider>().isOtpLoading,
                otpCounter:
                    context.watch<TalentPoolProvider>().resendOtpCounter,
                canResendOtp:
                    context.watch<TalentPoolProvider>().canResendOtp(),
                onSubmitted: () async {
                  if (_otpFormKey.currentState!.validate()) {
                    if (context.read<TalentPoolProvider>().isOtpLoading) return;

                    state(() =>
                        context.read<TalentPoolProvider>().isOtpLoading = true);
                    try {
                      PostActivityUseCase.exec(ActivityRequest(
                          type: ActivityTypeUtil.webVerifyOtp,
                          extra: ActivityExtraRequest(
                              state: "tap",
                              widget: "button",
                              screen: "talent pool")));

                      String? idToken = await _confirmOTP(
                          confirmationResult, _otpController.text);

                      _regisByFirebaseOtp(idToken!);
                    } on FirebaseAuthException catch (error) {
                      if (error.code == "invalid-verification-code") {
                        state(() {
                          _otpErrorMessage = "Kode OTP tidak sesuai";
                          context.read<TalentPoolProvider>().isOtpLoading =
                              false;
                        });
                      }
                    } catch (e) {
                      rethrow;
                    }
                  }
                },
                onResendOtp: () async {
                  _talentPoolProvider.startOtpCountdown();
                  try {
                    PostActivityUseCase.exec(ActivityRequest(
                        type: ActivityTypeUtil.webResendOtp,
                        extra: ActivityExtraRequest(
                            state: "tap",
                            widget: "button",
                            screen: "talent pool")));

                    await auth.signInWithPhoneNumber(
                        _phoneCountryCode + _phoneNumberController.text);
                    state(() => context
                        .read<TalentPoolProvider>()
                        .isOtpLoading = false);
                  } catch (_) {
                    rethrow;
                  }
                },
                onClosed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webCancelVerifyOtp,
                      extra: ActivityExtraRequest(
                          state: "tap",
                          widget: "button",
                          screen: "talent pool")));

                  state(() {
                    context.read<TalentPoolProvider>().isOtpLoading = false;
                    _otpController.text = "";
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

  Future<String?> _confirmOTP(
      ConfirmationResult confirmationResult, String otpCode) async {
    try {
      var userCredential = await confirmationResult.confirm(otpCode);

      String? idToken = await userCredential.user?.getIdToken();

      return idToken;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void _regisByFirebaseOtp(String idToken) {
    RegisByFirebaseOtpRequest request = RegisByFirebaseOtpRequest(
        idToken: idToken,
        phoneNumber: _phoneCountryCode + _phoneNumberController.text,
        referralBy: _referralController.text);

    _talentPoolProvider.regisByFirebaseOtp(request).then(
        (regisByFirebaseOtpResponse) async {
      entity_user.User user = await _talentPoolProvider.fetchProfile();

      if (user.name.isNotEmpty) {
        _talentPoolProvider.talentPoolCVResponse =
            TalentPoolCVResponse(id: user.id!, phoneNumber: user.phoneNumber);

        if (!mounted) return;
        Navigator.pop(context);
        _talentPoolProvider.pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        CreateTalentPoolCVRequest request = CreateTalentPoolCVRequest(
            pasPhoto: _uploadedPasPhoto,
            type: "Employee",
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneCountryCode + _phoneNumberController.text,
            gender: _selectedGender,
            married: _selectedMarriedStatus,
            religion: _selectedReligion,
            birthDate: selectedBirthDate!,
            city: _selectedCity,
            industry: _selectedIndustry,
            companyName: _companyNameController.text,
            position: _positionController.text,
            startYear: _selectedStartYear,
            createEducationFormalRequests:
                _talentPoolProvider.educationFormalRequests,
            createEducationNonFormalRequests:
                _talentPoolProvider.educationNonFormalRequests,
            createExperienceRequests: _talentPoolProvider.experienceRequests);

        _talentPoolProvider.saveCV(request).then((response) {
          Navigator.pop(context);
          if (response.id.isNotEmpty) {
            _talentPoolProvider.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }
        });
      }
    }).catchError(
        (error) => showDialog<Null>(
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
                    state(() {
                      context.read<TalentPoolProvider>().isOtpLoading = loading;
                    });
                    Navigator.of(context).pop();
                  },
                );
              });
            }),
        test: (error) => error is InternalServerErrorException);
  }

  Widget _showStillWorkingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nama Perusahaan"),
        SimpleOutlinedTextInput(
          controller: _companyNameController,
          hintText: "nama perusahaan",
        ),
        const Text("Posisi"),
        SimpleOutlinedTextInput(
          controller: _positionController,
          hintText: "posisi",
        ),
        const Text("Tahun Mulai"),
        SimpleOutlinedDropdownSearch(
            items: DatePickerUtil.generateStartYears()
                .map((year) => year.toString())
                .toList(),
            hintText: "tahun mulai",
            dropdownBuilder: (context, _) {
              return _selectedStartYear.isNotEmpty
                  ? Text(_selectedStartYear)
                  : const Text("tahun mulai");
            },
            onChanged: (selectedYear) {
              setState(() {
                _selectedStartYear = selectedYear;
              });
            }),
      ],
    );
  }

  Future<void> _openEducationFormalDialog(BuildContext context) => showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext buildContext) {
        return EducationFormalDialog(
          buildContext: buildContext,
        );
      });

  Future<void> _openEducationNonFormalDialog(BuildContext context) =>
      showDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) {
            return const EducationNonFormalDialog();
          });

  Future<void> _openExperienceDialog(BuildContext context) => showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return const ExperienceDialog();
      });

  List<Widget> _buildEducationFormalInformation() {
    List<CreateEducationFormalRequest> educationFormalRequests =
        _talentPoolProvider.educationFormalRequests;

    List<Widget> educationFormalInformationWidgets = [];

    educationFormalInformationWidgets = educationFormalRequests.map((request) {
      return EducationInformation(
        indexWidget: request.indexWidget,
        startYear: request.startYear,
        endYear: request.endYear,
        educationPlace: request.educationPlace,
        onEdit: (index) {
          showDialog(
              context: context,
              builder: (buildContext) {
                return EducationFormalDialog(
                  indexWidget: index,
                  buildContext: buildContext,
                );
              });
        },
        onDelete: (index) {
          _talentPoolProvider.deleteEducationFormal = index;
        },
      );
    }).toList();

    return educationFormalInformationWidgets;
  }

  List<Widget> _buildEducationNonFormalInformation() {
    List<CreateEducationNonFormalRequest> educationNonFormalRequests =
        _talentPoolProvider.educationNonFormalRequests;

    List<Widget> educationNonFormalInformationWidgets = [];

    educationNonFormalInformationWidgets =
        educationNonFormalRequests.map((request) {
      return EducationInformation(
        indexWidget: request.indexWidget,
        startYear: request.startYear,
        endYear: request.endYear!,
        educationPlace: request.educationPlace,
        onEdit: (index) {
          showDialog(
              context: context,
              builder: (context) {
                return EducationNonFormalDialog(indexWidget: index);
              });
        },
        onDelete: (index) {
          _talentPoolProvider.deleteEducationNonFormal = index;
        },
      );
    }).toList();

    return educationNonFormalInformationWidgets;
  }

  List<Widget> _buildExperienceInformation() {
    List<CreateExperienceRequest> experienceRequest =
        _talentPoolProvider.experienceRequests;

    List<Widget> experienceRequestWidgets = [];

    experienceRequestWidgets = experienceRequest.map((request) {
      return ExperienceInformation(
        indexWidget: request.indexWidget,
        startYear: request.startYear,
        endYear: request.endYear,
        company: request.companyName,
        profession: request.profession,
        onEdit: (index) {
          showDialog(
              context: context,
              builder: (context) {
                return ExperienceDialog(indexWidget: index);
              });
        },
        onDelete: (index) {
          _talentPoolProvider.deleteExperience = index;
        },
      );
    }).toList();

    return experienceRequestWidgets;
  }

  void _clearIsStillWorkingFormData() {
    _companyNameController.text = "";
    _positionController.text = "";
    _selectedStartYear = "";
  }

  void _validateEducationFormal() {
    if (_talentPoolProvider.educationFormalRequests.isEmpty) {
      _educationFormalErrorMessage = "Mohon kolom ini di isi.";
    } else {
      _educationFormalErrorMessage = null;
    }
  }

  void _validatePasPhoto() {
    if (_uploadedPasPhoto == null) {
      _pasPhotoErrorMessage = "Mohon kolom ini di isi.";
    } else if (!FormUtil.isImageLessThanOneMb(
        _uploadedPasPhoto!.lengthInBytes)) {
      _pasPhotoErrorMessage = "Foto tidak boleh lebih dari 1Mb.";
    } else {
      _pasPhotoErrorMessage = "";
    }
  }
}
