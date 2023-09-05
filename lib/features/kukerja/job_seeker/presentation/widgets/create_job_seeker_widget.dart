import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/domain/entities/user_type.dart';
import 'package:kukerja_web/core/utils/company_information_util.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/core/widgets/heading_2.dart';
import 'package:kukerja_web/core/widgets/heading_3.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_picker_input.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_input.dart';
import 'package:kukerja_web/core/widgets/small_loading_button.dart';
import 'package:kukerja_web/core/widgets/small_text_button.dart';
import 'package:kukerja_web/core/widgets/small_text_icon_button.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_experience_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_job_seeker_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/responses/create_job_seeker_response.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/providers/job_seeker_provider.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/education_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/education_non_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/experience_dialog.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/utils/job_seeker_util.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_information.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/experience_information.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class CreateJobSeekerWidget extends StatefulWidget {
  const CreateJobSeekerWidget({Key? key}) : super(key: key);

  @override
  State<CreateJobSeekerWidget> createState() => _CreateJobSeekerWidgetState();
}

class _CreateJobSeekerWidgetState extends State<CreateJobSeekerWidget> {
  static const double _space = 20;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController(),
      _email = TextEditingController(),
      _birthDate = TextEditingController(),
      _companyName = TextEditingController(),
      _position = TextEditingController();

  final FilePicker _filePicker = FilePicker.platform;

  late JobSeekerProvider _jobSeekerProvider;

  bool _isStillWorking = false, _isLoading = false;

  String _selectedGender = "",
      _selectedMarriedStatus = "",
      _selectedCity = "",
      _selectedIndustry = "",
      _selectedReligion = "",
      _selectedStartYear = "";

  String? _pasPhotoErrorMessage, _educationFormalErrorMessage;

  DateTime? _selectedBirthDate;

  Uint8List? _uploadedPasPhoto;

  @override
  void dispose() {
    super.dispose();

    _name.dispose();
    _email.dispose();
    _birthDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _jobSeekerProvider = context.watch<JobSeekerProvider>();
    SizeConfig().init(context);

    return SizedBox(
      child: Row(
        children: [
          if (!ResponsiveWidget.isSmallScreen(context))
            Flexible(
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
          Flexible(
              flex: 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 48.0),
                  child: Center(
                    child: SizedBox(
                      width: 640,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child:
                                    Heading3(text: "Informasi Pencari Kerja")),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Expanded(
                                    child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              var pasPhoto = await _filePicker
                                                  .pickFiles(
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                    'jpg',
                                                    'jpeg',
                                                    'png'
                                                  ]);

                                              if (pasPhoto != null) {
                                                setState(() {
                                                  _uploadedPasPhoto = pasPhoto
                                                      .files.first.bytes;
                                                });
                                              }
                                            },
                                            icon: FontAwesomeIcons.paperclip),
                                        if (_pasPhotoErrorMessage != null)
                                          ShowValidationMessage(
                                              message: _pasPhotoErrorMessage!)
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
                                        controller: _name,
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
                                        controller: _email,
                                        customValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Mohon kolom ini di isi.';
                                          } else if (!EmailValidator.validate(
                                              value)) {
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
                                        items: const [
                                          "Belum Menikah",
                                          "Menikah"
                                        ],
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
                                        items: _jobSeekerProvider.religions,
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
                                        controller: _birthDate,
                                        hintText: "pilih tanggal lahir",
                                        onTap: () async {
                                          _selectedBirthDate =
                                              await DatePickerUtil.datePicker(
                                                  context);

                                          if (_selectedBirthDate != null) {
                                            setState(() {
                                              _birthDate.text =
                                                  DateFormat.yMMMMd('idr')
                                                      .format(
                                                          _selectedBirthDate!);
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
                                        items: _jobSeekerProvider.cities,
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
                                        items: _jobSeekerProvider.industries,
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title:
                                                const Text("Pendidikan Formal"),
                                            subtitle:
                                                _educationFormalErrorMessage !=
                                                        null
                                                    ? ShowValidationMessage(
                                                        message:
                                                            _educationFormalErrorMessage!)
                                                    : const SizedBox.shrink(),
                                            trailing: SmallTextButton.square(
                                                text: "+ Tambah Pendidikan",
                                                onPress: () {
                                                  JobSeekerUtil
                                                      .openEducationFormalDialog(
                                                          context);
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: const Text(
                                                "Pendidikan Non Formal"),
                                            subtitle: const SizedBox.shrink(),
                                            trailing: SmallTextButton.square(
                                                text: "+ Tambah Pendidikan",
                                                onPress: () {
                                                  JobSeekerUtil
                                                      .openEducationNonFormalDialog(
                                                          context);
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title:
                                                const Text("Pengalaman Kerja"),
                                            subtitle: const Text(
                                                "Isi pengalaman terbaikmu"),
                                            trailing: SmallTextButton.square(
                                                text: "+ Tambah Pengalaman",
                                                onPress: () {
                                                  JobSeekerUtil
                                                      .openExperienceDialog(
                                                          context);
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
                            SmallLoadingButton(
                                buttonSize: const Size.fromHeight(50),
                                text: "Simpan Data",
                                loadingText: "Menyimpan Data",
                                onPressed: () {
                                  setState(() {
                                    _validatePasPhoto();
                                    _validateEducationFormal();
                                  });
                                  if (_formKey.currentState!.validate() &&
                                      _uploadedPasPhoto != null &&
                                      _educationFormalErrorMessage == null) {
                                    if (_isLoading) return;

                                    setState(() => _isLoading = true);

                                    _create();
                                  } else {
                                    FormUtil.showToast(context);
                                  }
                                },
                                isLoading: _isLoading)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _create() async {
    try {
      String? phoneNumber = await LocalStorageUtil.readPhoneNumber();

      CreateJobSeekerRequest createJobSeekerRequest = CreateJobSeekerRequest(
          pasPhoto: _uploadedPasPhoto,
          type: UserType.jobSeeker,
          name: _name.text,
          email: _email.text,
          gender: _selectedGender,
          married: _selectedMarriedStatus,
          religion: _selectedReligion,
          city: _selectedCity,
          industry: _selectedIndustry,
          birthDate: _selectedBirthDate!,
          phoneNumber: phoneNumber!,
          createEducationFormalRequests:
              _jobSeekerProvider.educationFormalRequests,
          createEducationNonFormalRequests:
              _jobSeekerProvider.educationNonFormalRequests,
          createExperienceRequests: _jobSeekerProvider.experienceRequests,
          companyName: _companyName.text,
          position: _position.text,
          startYear: _selectedStartYear);

      CreateJobSeekerResponse createJobSeekerResponse =
          await _jobSeekerProvider.create(createJobSeekerRequest);

      String? isFromTalentPool = await LocalStorageUtil.readFromTalentPool();

      if (createJobSeekerResponse.id.isNotEmpty && isFromTalentPool != null ) {
        await LocalStorageUtil.deleteFromTalentPool();
        html.window.location.replace("/talent-pools");
      } else {
        html.window.location.replace("/");
      }

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Widget _showStillWorkingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nama Perusahaan"),
        SimpleOutlinedTextInput(
          controller: _companyName,
          hintText: "nama perusahaan",
        ),
        const Text("Posisi"),
        SimpleOutlinedTextInput(
          controller: _position,
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

  List<Widget> _buildEducationFormalInformation() {
    List<CreateEducationFormalRequest> educationFormalRequests =
        _jobSeekerProvider.educationFormalRequests;

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
          _jobSeekerProvider.deleteEducationFormal = index;
        },
      );
    }).toList();

    return educationFormalInformationWidgets;
  }

  List<Widget> _buildEducationNonFormalInformation() {
    List<CreateEducationNonFormalRequest> educationNonFormalRequests =
        _jobSeekerProvider.educationNonFormalRequests;

    List<Widget> educationNonFormalInformationWidgets = [];

    educationNonFormalInformationWidgets =
        educationNonFormalRequests.map((request) {
      return EducationInformation(
        indexWidget: request.indexWidget,
        startYear: request.startYear,
        endYear: request.endYear,
        educationPlace: request.educationPlace,
        onEdit: (index) {
          showDialog(
              context: context,
              builder: (context) {
                return EducationNonFormalDialog(indexWidget: index);
              });
        },
        onDelete: (index) {
          _jobSeekerProvider.deleteEducationNonFormal = index;
        },
      );
    }).toList();

    return educationNonFormalInformationWidgets;
  }

  List<Widget> _buildExperienceInformation() {
    List<CreateExperienceRequest> experienceRequest =
        _jobSeekerProvider.experienceRequests;

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
          _jobSeekerProvider.deleteExperience = index;
        },
      );
    }).toList();

    return experienceRequestWidgets;
  }

  void _clearIsStillWorkingFormData() {
    _companyName.text = "";
    _position.text = "";
    _selectedStartYear = "";
  }

  void _validateEducationFormal() {
    if (_jobSeekerProvider.educationFormalRequests.isEmpty) {
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
