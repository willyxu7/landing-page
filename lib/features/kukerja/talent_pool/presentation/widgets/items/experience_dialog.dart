import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/utils/uuid_util.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_experience_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/update_experience_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/widgets/simple_outlined_dropdown_button.dart';
import '../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../../../core/widgets/small_outline_button.dart';
import '../../../../landing_page/style/app_color.dart';

class ExperienceDialog extends StatefulWidget {
  final String? indexWidget;

  const ExperienceDialog({this.indexWidget, Key? key}) : super(key: key);

  @override
  State<ExperienceDialog> createState() => _ExperienceDialogState();
}

class _ExperienceDialogState extends State<ExperienceDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedProfession,
      _selectedIndustry,
      _selectedStartMonth,
      _selectedEndMonth,
      _selectedStartYear,
      _selectedEndYear;

  late CreateExperienceRequest _chosenExperience;

  List<int> _endYears = [];

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  @override
  void initState() {
    if (FormUtil.isEditForm(widget.indexWidget)) _setEditFormValue();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pengalaman Kerja"),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 600,
          height: ResponsiveWidget.isSmallScreen(context) ? null : 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nama Perusahaan"),
                SimpleOutlinedTextInput(
                  controller: _companyNameController,
                  hintText: "nama perusahaan",
                ),
                const Text("Profesi"),
                SimpleOutlinedDropdownSearch(
                  items: context.read<TalentPoolProvider>().professions,
                  hintText: "pilih profesi",
                  selectedItem: _selectedProfession,
                  onChanged: (profession) {
                    setState(() {
                      _selectedProfession = profession;
                    });
                  },
                  dropdownBuilder: (context, _) {
                    return _selectedProfession != null
                        ? Text(_selectedProfession!)
                        : const Text("pilih profesi");
                  },
                ),
                const Text("Industri"),
                SimpleOutlinedDropdownSearch(
                  items: context.read<TalentPoolProvider>().industries,
                  hintText: "pilih industri",
                  selectedItem: _selectedIndustry,
                  onChanged: (industry) {
                    setState(() {
                      _selectedIndustry = industry;
                    });
                  },
                  dropdownBuilder: (context, _) {
                    return _selectedIndustry != null
                        ? Text(_selectedIndustry!)
                        : const Text("pilih profesi");
                  },
                ),
                const Text("Pengalaman"),
                SimpleOutlinedTextArea(
                  controller: _experienceController,
                  hintText: "ceritakan pengalamanmu (optional)",
                  optional: true,
                ),
                const Text("Mulai Kerja"),
                Row(
                  children: [
                    Expanded(
                        child: SimpleOutlinedDropdownButton(
                            items: DatePickerUtil.indonesianMonths(),
                            hint: "bulan",
                            initValue:
                                _selectedStartMonth ?? _selectedStartMonth,
                            onChanged: (month) {
                              setState(() {
                                _selectedStartMonth = month;
                              });
                            })),
                    const SizedBox(width: 10),
                    Expanded(
                        child: SimpleOutlinedDropdownSearch(
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
                      dropdownBuilder: (context, selectedItem) {
                        return (_selectedStartYear != null)
                            ? Text(_selectedStartYear!)
                            : const Text("tahun mulai");
                      },
                    )),
                  ],
                ),
                const Text("Selesai Kerja"),
                Row(
                  children: [
                    Expanded(
                        child: SimpleOutlinedDropdownButton(
                            items: DatePickerUtil.indonesianMonths(),
                            hint: "bulan",
                            initValue: _selectedEndMonth ?? _selectedEndMonth,
                            onChanged: (month) {
                              setState(() {
                                _selectedEndMonth = month;
                              });
                            })),
                    const SizedBox(width: 10),
                    Expanded(
                        child: SimpleOutlinedDropdownSearch(
                            items: _endYears
                                .map((year) => year.toString())
                                .toList(),
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
                            })),
                  ],
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
                    if (_formKey.currentState!.validate()) {
                      FormUtil.isEditForm(widget.indexWidget)
                          ? _updateExperience()
                          : _saveExperience();
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
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ]
          : [
              SmallOutlineButton(
                  text: "Batal",
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SmallButton(
                  text: "Simpan",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FormUtil.isEditForm(widget.indexWidget)
                          ? _updateExperience()
                          : _saveExperience();
                      Navigator.pop(context);
                    } else {
                      FormUtil.showToast(context);
                    }
                  })
            ],
    );
  }

  void _saveExperience() {
    CreateExperienceRequest request = CreateExperienceRequest(
        indexWidget: UuidUtil().generateUuidV1(),
        companyName: _companyNameController.text,
        profession: _selectedProfession!,
        industry: _selectedIndustry!,
        experience: _experienceController.text,
        startMonth: _selectedStartMonth!,
        endMonth: _selectedEndMonth!,
        startYear: _selectedStartYear!,
        endYear: _selectedEndYear!);

    context.read<TalentPoolProvider>().addExperience = request;
  }

  void _updateExperience() {
    UpdateExperienceRequest request = UpdateExperienceRequest(
        companyName: _companyNameController.text,
        profession: _selectedProfession!,
        industry: _selectedIndustry!,
        experience: _experienceController.text,
        startMonth: _selectedStartMonth!,
        endMonth: _selectedEndMonth!,
        startYear: _selectedStartYear!,
        endYear: _selectedEndYear!);

    context
        .read<TalentPoolProvider>()
        .updateExperience(widget.indexWidget!, request);
  }

  void _setEditFormValue() {
    _chosenExperience = context
        .read<TalentPoolProvider>()
        .experienceRequests
        .firstWhere((request) => request.indexWidget == widget.indexWidget);

    setState(() {
      _companyNameController.text = _chosenExperience.companyName;
      _selectedProfession = _chosenExperience.profession;
      _selectedIndustry = _chosenExperience.industry;
      _experienceController.text = _chosenExperience.experience!;
      _selectedStartMonth = _chosenExperience.startMonth;
      _selectedEndMonth = _chosenExperience.endMonth;
      _selectedStartYear = _chosenExperience.startYear;
      _selectedEndYear = _chosenExperience.endYear;

      _endYears = DatePickerUtil.generateEndYears(_selectedStartYear!);
    });
  }
}
