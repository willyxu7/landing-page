import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/utils/uuid_util.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/update_education_non_formal_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/size_config.dart';
import '../../../../../../core/utils/form_util.dart';
import '../../../../../../core/widgets/show_validation_message.dart';
import '../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../../../core/widgets/small_outline_button.dart';
import '../../../../../../core/widgets/small_text_icon_button.dart';
import '../../../../landing_page/style/app_color.dart';

class EducationNonFormalDialog extends StatefulWidget {
  final String? indexWidget;

  const EducationNonFormalDialog({this.indexWidget, Key? key})
      : super(key: key);

  @override
  State<EducationNonFormalDialog> createState() =>
      _EducationNonFormalDialogState();
}

class _EducationNonFormalDialogState extends State<EducationNonFormalDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isStillStudying = false, _isEndYearOptional = false;
  Uint8List? _uploadedCertificate;
  String? _selectedStartYear,
      _selectedEndYear,
      _selectedCourse,
      _certificateErrorMessage;
  List<int> _endYears = [];
  late CreateEducationNonFormalRequest _chosenEducationNonFormal;

  final TextEditingController _educationPlaceController =
      TextEditingController();
  final TextEditingController _educationExperienceController =
      TextEditingController();

  @override
  void initState() {
    if (_isEditForm()) {
      _setEditFormValue();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AlertDialog(
      title: const Text("Pendidikan Non Formal"),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 600,
          height: ResponsiveWidget.isSmallScreen(context) ? SizeConfig.screenHeight * 0.8  : 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tempat Pendidikan"),
                SimpleOutlinedTextInput(
                  controller: _educationPlaceController,
                  hintText: "tempat pendidikan",
                ),
                const Text("Program Studi"),
                SimpleOutlinedDropdownSearch(
                  items: context.read<TalentPoolProvider>().education.courses,
                  hintText: "pilih program studi",
                  selectedItem: _selectedCourse,
                  onChanged: (course) {
                    _selectedCourse = course;
                  },
                  dropdownBuilder: (context, _) {
                    return _selectedCourse != null
                        ? Text(_selectedCourse!)
                        : const Text("pilih program studi");
                  },
                ),
                const Text("Pengalaman"),
                SimpleOutlinedTextArea(
                  controller: _educationExperienceController,
                  hintText: "apa yang dipelajari (optional)",
                  optional: true,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColor.secondary,
                  title: const Text("Saya masih belajar disini"),
                  value: _isStillStudying,
                  onChanged: (value) {
                    setState(() {
                      _isStillStudying = value!;
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
                          },
                          dropdownBuilder: (context, _) {
                            return _selectedStartYear != null
                                ? Text(_selectedStartYear!)
                                : const Text("tahun mulai");
                          },
                        ),
                      ],
                    )),
                    if (!_isStillStudying) const SizedBox(width: 10),
                    if (!_isStillStudying) _showEndYearStudy()
                  ],
                ),
                if (!_isStillStudying) _showUploadCertificate(),
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
                      _isEditForm()
                          ? _updateEducationNonFormal()
                          : _saveEducationNonFormal();
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
                      _isEditForm()
                          ? _updateEducationNonFormal()
                          : _saveEducationNonFormal();
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
            items: _endYears.map((year) => year.toString()).toList(),
            hintText: "tahun selesai",
            dropdownBuilder: (context, selectedItem) {
              return (_selectedEndYear != null)
                  ? Text(_selectedEndYear!)
                  : const Text("tahun selesai");
            },
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
          text: "Upload Sertifikat",
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

  void _validateUploadCertificate() {
    if (!FormUtil.isImageLessThanOneMb(_uploadedCertificate?.lengthInBytes)) {
      _certificateErrorMessage = "Foto tidak boleh lebih dari 1Mb.";
    } else {
      _certificateErrorMessage = null;
    }
  }

  void _saveEducationNonFormal() {
    CreateEducationNonFormalRequest request = CreateEducationNonFormalRequest(
        indexWidget: UuidUtil().generateUuidV1(),
        educationPlace: _educationPlaceController.text,
        course: _selectedCourse!,
        educationExperience: _educationExperienceController.text,
        isStillStudying: _isStillStudying,
        startYear: _selectedStartYear!,
        endYear: _selectedEndYear,
        certificate: _uploadedCertificate);

    context.read<TalentPoolProvider>().addEducationNonFormal = request;
  }

  void _updateEducationNonFormal() {
    UpdateEducationNonFormalRequest request = UpdateEducationNonFormalRequest(
        educationPlace: _educationPlaceController.text,
        course: _selectedCourse!,
        educationExperience: _educationExperienceController.text,
        isStillStudying: _isStillStudying,
        startYear: _selectedStartYear!,
        endYear: _selectedEndYear,
        certificate: _uploadedCertificate);

    context
        .read<TalentPoolProvider>()
        .updateEducationNonFormal(widget.indexWidget!, request);
  }

  bool _isEditForm() {
    return widget.indexWidget != null;
  }

  void _setEditFormValue() {
    _chosenEducationNonFormal = context
        .read<TalentPoolProvider>()
        .educationNonFormalRequests
        .firstWhere((educationNonFormal) =>
            educationNonFormal.indexWidget == widget.indexWidget);

    setState(() {
      _educationPlaceController.text = _chosenEducationNonFormal.educationPlace;
      _selectedCourse = _chosenEducationNonFormal.course;
      _educationExperienceController.text =
          _chosenEducationNonFormal.educationExperience!;
      _isStillStudying = _chosenEducationNonFormal.isStillStudying;
      _selectedStartYear = _chosenEducationNonFormal.startYear;
      _selectedEndYear = _chosenEducationNonFormal.endYear;
      _uploadedCertificate = _chosenEducationNonFormal.certificate;

      _endYears = DatePickerUtil.generateEndYears(_selectedStartYear!);
    });
  }
}
