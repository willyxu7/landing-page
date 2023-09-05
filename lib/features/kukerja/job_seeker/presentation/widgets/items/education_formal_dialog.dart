import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/utils/uuid_util.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_area.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_text_input.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/core/widgets/small_text_icon_button.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/create_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/data/models/requests/update_education_formal_request.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/providers/job_seeker_provider.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:provider/provider.dart';



class EducationFormalDialog extends StatefulWidget {
  final String? indexWidget;
  final BuildContext buildContext;

  const EducationFormalDialog(
      {this.indexWidget, required this.buildContext, Key? key})
      : super(key: key);

  @override
  State<EducationFormalDialog> createState() => _EducationFormalDialogState();
}

class _EducationFormalDialogState extends State<EducationFormalDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _educationPlaceController =
          TextEditingController(),
      _educationExperienceController = TextEditingController();

  late CreateEducationFormalRequest _chosenEducationFormal;
  late JobSeekerProvider _jobSeekerProvider;

  bool isStillStudying = false,
      _isShowStudyProgram = true,
      _isEndYearOptional = false;
  Uint8List? _uploadedCertificate;
  String? _certificateErrorMessage,
      _selectedEducationLevel,
      _selectedStudyProgram,
      _selectedStartYear,
      _selectedEndYear;
  List<int> _endYears = [];

  @override
  void initState() {
    if (_isEditForm()) {
      _setEditFormValue();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _educationPlaceController.dispose();
    _educationExperienceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _jobSeekerProvider = context.watch<JobSeekerProvider>();
    SizeConfig().init(context);

    return AlertDialog(
      title: const Text("Pendidikan Formal"),
      scrollable: true,
      content: SizedBox(
        width: 600,
        height: ResponsiveWidget.isSmallScreen(context)
            ? SizeConfig.screenHeight * 0.8
            : 600,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Jenjang Pendidikan"),
                SimpleOutlinedDropdownSearch(
                    items: _jobSeekerProvider.educationLevels,
                    hintText: "pilih jenjang pendidikan",
                    dropdownBuilder: (context, _) {
                      return _selectedEducationLevel != null
                          ? Text(_selectedEducationLevel!)
                          : const Text("pilih jenjang pendidikan");
                    },
                    selectedItem: _selectedEducationLevel,
                    onChanged: (String educationLevel) {
                      setState(() {
                        _selectedEducationLevel = educationLevel;
                        _checkEducationLevel(educationLevel);
                      });
                    }),
                const Text("Tempat Pendidikan"),
                SimpleOutlinedTextInput(
                  controller: _educationPlaceController,
                  hintText: "tempat pendidikan",
                ),
                if (_isShowStudyProgram) _showStudyProgram(),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColor.secondary,
                  title: const Text("Saya masih belajar disini"),
                  value: isStillStudying,
                  onChanged: (value) {
                    setState(() {
                      isStillStudying = value!;
                      _certificateErrorMessage = null;
                      _isEndYearOptional = !_isEndYearOptional;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tahun Mulai"),
                        SimpleOutlinedDropdownSearch(
                            items: DatePickerUtil.generateStartYears()
                                .map((year) => year.toString())
                                .toList(),
                            hintText: "tahun mulai",
                            selectedItem: _selectedStartYear,
                            dropdownBuilder: (context, _) {
                              return _selectedStartYear != null
                                  ? Text(_selectedStartYear!)
                                  : const Text("tahun mulai");
                            },
                            onChanged: (selectedYear) {
                              setState(() {
                                _selectedStartYear = selectedYear;
                                _endYears = DatePickerUtil.generateEndYears(
                                    _selectedStartYear!);

                                if (_selectedEndYear != null) {
                                  if (int.parse(_selectedStartYear!) >
                                      (int.tryParse(_selectedEndYear!) ?? 0)) {
                                    _selectedEndYear = "";
                                  }
                                }
                              });
                            }),
                      ],
                    )),
                    if (!isStillStudying) const SizedBox(width: 10),
                    if (!isStillStudying) _showEndYearStudy()
                  ],
                ),
                if (!isStillStudying) _showUploadCertificate(),
                if (_uploadedCertificate != null)
                  Image.memory(
                    _uploadedCertificate!,
                    width: 200,
                    height: 300,
                  ),
                const SizedBox(height: 300)
              ],
            ),
          ),
        ),
      ),
      actions: ResponsiveWidget.isSmallScreen(context)
          ? [
              SmallButton(
                  buttonSize: const Size.fromHeight(50),
                  text: "Simpan",
                  onPressed: () {
                    setState(() {
                      _validateUploadCertificate();
                    });
                    if (_formKey.currentState!.validate() &&
                        _certificateErrorMessage == null) {
                      if (_isEditForm()) {
                        _updateEducationFormal();
                      } else {
                        _saveEducationFormal();
                      }
                      Navigator.pop(context);
                    } else {
                      FormUtil.showToast(context);
                    }
                  }),
              const SizedBox(height: 20),
              SmallOutlineButton(
                  buttonSize: const Size.fromHeight(50),
                  text: "Batal",
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  onPressed: () => Navigator.pop(context)),
            ]
          : [
              SmallOutlineButton(
                  text: "Batal",
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  onPressed: () => Navigator.pop(context)),
              SmallButton(
                  text: "Simpan",
                  onPressed: () {
                    setState(() {
                      _validateUploadCertificate();
                    });
                    if (_formKey.currentState!.validate() &&
                        _certificateErrorMessage == null) {
                      if (_isEditForm()) {
                        _updateEducationFormal();
                      } else {
                        _saveEducationFormal();
                      }
                      Navigator.pop(context);
                    } else {
                      FormUtil.showToast(context);
                    }
                  })
            ],
    );
  }

  Widget _showEndYearStudy() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tahun Selesai"),
        SimpleOutlinedDropdownSearch(
            optional: _isEndYearOptional,
            items: _endYears.map((year) => year.toString()).toList(),
            selectedItem: _selectedEndYear,
            dropdownBuilder: (context, selectedItem) {
              return (_selectedEndYear != null)
                  ? Text(_selectedEndYear!)
                  : const Text("tahun selesai");
            },
            hintText: "tahun selesai",
            onChanged: (selectedYear) {
              if (selectedYear != null) {
                _selectedEndYear = selectedYear;
              }
            })
      ],
    ));
  }

  Widget _showUploadCertificate() {
    return Column(
      children: [
        SmallTextIconButton.square(
          text: "Upload Ijazah",
          onPressed: () async {
            var picked = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'jpeg', 'png']);

            if (picked != null) {
              setState(() {
                _uploadedCertificate = picked.files.first.bytes!;
              });
            }
          },
          icon: FontAwesomeIcons.paperclip,
        ),
        if (_certificateErrorMessage != null)
          ShowValidationMessage(message: _certificateErrorMessage!)
      ],
    );
  }

  Widget _showStudyProgram() {
    DatePickerUtil.generateStartYears();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Program Studi"),
        SimpleOutlinedDropdownSearch(
            items: _showStudyProgramsBasedOnSelectedLevel(),
            selectedItem: _selectedStudyProgram,
            hintText: "pilih program studi",
            dropdownBuilder: (context, _) {
              return _selectedStudyProgram != null
                  ? Text(_selectedStudyProgram!)
                  : const Text("pilih program studi");
            },
            onChanged: (selectedStudyProgram) {
              setState(() {
                _selectedStudyProgram = selectedStudyProgram;
              });
            }),
        const Text("Pengalaman"),
        SimpleOutlinedTextArea(
          controller: _educationExperienceController,
          hintText: "apa yang dipelajari (optional)",
          optional: true,
        ),
      ],
    );
  }

  List<String> _showStudyProgramsBasedOnSelectedLevel() {
    List<String> studyPrograms = _jobSeekerProvider.education.studyPrograms;

    if (_selectedEducationLevel == "SMK") {
      studyPrograms = _jobSeekerProvider.education.smk;
    }

    return studyPrograms;
  }

  void _saveEducationFormal() {
    CreateEducationFormalRequest educationFormalRequest =
        CreateEducationFormalRequest(
            indexWidget: UuidUtil().generateUuidV1(),
            educationLevel: _selectedEducationLevel!,
            educationPlace: _educationPlaceController.text,
            studyProgram: _selectedStudyProgram,
            educationExperience: _educationExperienceController.text,
            isStillStudying: isStillStudying,
            startYear: _selectedStartYear!,
            endYear: _selectedEndYear,
            certificate: _uploadedCertificate);

    _jobSeekerProvider.addEducationFormal = educationFormalRequest;
  }

  void _updateEducationFormal() {
    UpdateEducationFormalRequest request = UpdateEducationFormalRequest(
      educationLevel: _selectedEducationLevel!,
      educationPlace: _educationPlaceController.text,
      studyProgram: _selectedStudyProgram,
      educationExperience: _educationExperienceController.text,
      isStillStudying: isStillStudying,
      startYear: _selectedStartYear!,
      endYear: _selectedEndYear,
      certificate: _uploadedCertificate,
    );

    _jobSeekerProvider.updateEducationFormal(widget.indexWidget!, request);
  }

  void _setEditFormValue() {
    _chosenEducationFormal = context
        .read<JobSeekerProvider>()
        .educationFormalRequests
        .firstWhere((request) => request.indexWidget == widget.indexWidget);

    _checkEducationLevel(_chosenEducationFormal.educationLevel);

    setState(() {
      _selectedEducationLevel = _chosenEducationFormal.educationLevel;
      _educationPlaceController.text = _chosenEducationFormal.educationPlace;
      _selectedStudyProgram = _chosenEducationFormal.studyProgram;
      _educationExperienceController.text =
          _chosenEducationFormal.educationExperience!;
      isStillStudying = _chosenEducationFormal.isStillStudying;
      _selectedStartYear = _chosenEducationFormal.startYear;
      _selectedEndYear = _chosenEducationFormal.endYear;
      _uploadedCertificate = _chosenEducationFormal.certificate;

      _endYears = DatePickerUtil.generateEndYears(_selectedStartYear!);
    });
  }

  bool _isEditForm() {
    return widget.indexWidget != null;
  }

  void _validateUploadCertificate() {
    if (!FormUtil.isImageLessThanOneMb(_uploadedCertificate?.lengthInBytes)) {
      _certificateErrorMessage = "Foto tidak boleh lebih dari 1Mb.";
    } else {
      _certificateErrorMessage = null;
    }
  }

  void _checkEducationLevel(String educationLevel) {
    (educationLevel == "SD" ||
            educationLevel == "SMP" ||
            educationLevel == "SMA")
        ? _isShowStudyProgram = false
        : _isShowStudyProgram = true;
  }
}
