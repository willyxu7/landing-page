import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/data/models/responses/profession_data_response.dart';
import 'package:kukerja_web/core/domain/entities/education_qualification.dart';
import 'package:kukerja_web/core/domain/entities/salary_type.dart';
import 'package:kukerja_web/core/utils/form_util.dart';
import 'package:kukerja_web/core/utils/thousands_separator_input_formatter.dart';
import 'package:kukerja_web/core/widgets/paragraph_widget.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_number_input.dart';
import 'package:kukerja_web/core/widgets/small_loading_button.dart';
import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employee_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/find_candidate.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/find_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/candidate_reponse.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/domain/entities/user.dart';
import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/utils/time_picker_util.dart';
import '../../../../../../core/widgets/heading_3.dart';
import '../../../../../../core/widgets/heading_4.dart';
import '../../../../../../core/widgets/show_validation_message.dart';
import '../../../../../../core/widgets/simple_outlined_picker_input.dart';
import '../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../core/widgets/styled_multi_select_chip.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../landing_page/style/app_color.dart';
import '../../../data/models/requests/create_job_request.dart';
import '../../providers/sultan_recruitment_provider.dart';

class FindCandidateDesktop extends StatefulWidget {
  const FindCandidateDesktop({Key? key}) : super(key: key);

  @override
  State<FindCandidateDesktop> createState() => _FindCandidateDesktopState();
}

class _FindCandidateDesktopState extends State<FindCandidateDesktop> {
  late SultanRecruitmentProvider _sultanRecruitmentProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final double _spaceWidth = 16, _spaceHeight = 16;
  final TextEditingController _jobDescription = TextEditingController(),
      _salary = TextEditingController(),
      _startWork = TextEditingController(),
      _endWork = TextEditingController();

  bool _isFindLoading = false;

  List<String>? _workingDays;

  ProfessionDataResponse? _profession;
  EducationQualification? _educationQualification;
  SalaryType? _salaryType;

  String _gender = "", _age = "", _jobType = "";

  String? _workingDaysErrorMessage;

  TimeOfDay? _startWorkTime, _endWorkTime;

  @override
  void initState() {
    super.initState();

    _initFindCandidatePreviousData();
  }

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
                text: "Cari Kandidat",
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Profesi yang dicari"),
                    SimpleOutlinedDropdownSearch<ProfessionDataResponse>(
                        selectedItem: _profession,
                        hintText: "pilih profesi",
                        itemAsString: (profession) => profession.id,
                        items:
                            _sultanRecruitmentProvider.professionDataResponses,
                        onChanged: (ProfessionDataResponse selectedProfession) {
                          setState(() {
                            _profession = selectedProfession;
                          });
                        },
                        dropdownBuilder: (context, _) {
                          return _profession != null
                              ? Text(_profession!.id)
                              : const Text("pilih profesi",
                                  style: TextStyle(color: Colors.grey));
                        })
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
                    const Text("Deskripsi Pekerjaan"),
                    SimpleOutlinedTextArea(
                        controller: _jobDescription,
                        hintText: "jelaskan deskripsi pekerjaan anda")
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
                    const Text("Jenis Kelamin"),
                    SimpleOutlinedDropdownSearch<String>(
                        selectedItem: _gender,
                        showSearchBox: false,
                        hintText: "pilih gender",
                        items: const [...FormUtil.genders, "Pria & Wanita"],
                        onChanged: (selectedGender) {
                          setState(() => _gender = selectedGender);
                        },
                        dropdownBuilder: (context, _) {
                          return _gender.isNotEmpty
                              ? Text(_gender)
                              : const Text("pilih gender",
                                  style: TextStyle(color: Colors.grey));
                        })
                  ],
                )),
                SizedBox(width: _spaceWidth),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Umur"),
                    SimpleOutlinedDropdownSearch<String>(
                        selectedItem: _age,
                        showSearchBox: false,
                        hintText: "pilih umur",
                        items: FormUtil.ages,
                        onChanged: (selectedAge) {
                          setState(() => _age = selectedAge);
                        },
                        dropdownBuilder: (context, _) {
                          return _age.isNotEmpty
                              ? Text(_age)
                              : const Text("pilih umur",
                                  style: TextStyle(color: Colors.grey));
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
                    const Text("Pendidikan"),
                    SimpleOutlinedDropdownSearch<EducationQualification>(
                        selectedItem: _educationQualification,
                        itemAsString: (educationQualification) =>
                            educationQualification.title,
                        showSearchBox: false,
                        items: FormUtil.educationQualifications,
                        hintText: "pilih syarat pendidikan",
                        onChanged: (EducationQualification selectedEducation) {
                          _educationQualification = selectedEducation;
                        },
                        dropdownBuilder: (context, _) {
                          return _educationQualification != null
                              ? Text(_educationQualification!.title)
                              : const Text("pilih syarat pendidikan",
                                  style: TextStyle(color: Colors.grey));
                        })
                  ],
                )),
                SizedBox(width: _spaceWidth),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tipe Pekerjaan"),
                    SimpleOutlinedDropdownSearch<String>(
                        selectedItem: _jobType,
                        showSearchBox: false,
                        hintText: "pilih tipe pekerjaan",
                        items: const [
                          "Penuh Waktu",
                          "Paruh Waktu",
                          "Freelance",
                          "Sukarelawan"
                        ],
                        onChanged: (selectedJobType) {
                          setState(() => _jobType = selectedJobType);
                        },
                        dropdownBuilder: (context, _) {
                          return _jobType.isNotEmpty
                              ? Text(_jobType)
                              : const Text("pilih tipe pekerjaan",
                                  style: TextStyle(color: Colors.grey));
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
                    const Text("Gaji"),
                    SimpleOutlinedNumberInput(
                        inputFormatters: [ThousandsSeparatorInputFormatter()],
                        controller: _salary,
                        hintText: "masukkan gaji")
                  ],
                )),
                SizedBox(width: _spaceWidth),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(""),
                    SimpleOutlinedDropdownSearch<SalaryType>(
                        selectedItem: _salaryType,
                        showSearchBox: false,
                        itemAsString: (salaryType) => salaryType.label,
                        hintText: "pilih tipe gaji",
                        items: FormUtil.salaryTypes,
                        onChanged: (SalaryType selectedSalaryType) {
                          setState(() => _salaryType = selectedSalaryType);
                        },
                        dropdownBuilder: (context, _) {
                          return _salaryType != null
                              ? Text(_salaryType!.label)
                              : const Text("pilih tipe gaji",
                                  style: TextStyle(color: Colors.grey));
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
                    const Text("Hari Kerja"),
                    const SizedBox(height: 10),
                    StyledMultiSelectChip<String>(
                        items: FormUtil.days.map((day) {
                          return MultiSelectCard(value: day, label: day);
                        }).toList(),
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() => _workingDays = allSelectedItems);
                        }),
                    if (_workingDaysErrorMessage != null)
                      ShowValidationMessage(message: _workingDaysErrorMessage!)
                  ],
                )),
              ],
            ),
            SizedBox(height: _spaceHeight),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Jam Kerja"),
                    SimpleOutlinedPickerInput(
                        readOnly: true,
                        controller: _startWork,
                        hintText: "mulai kerja",
                        onTap: () async {
                          _startWorkTime = await showRoundedTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              theme: ThemeData(
                                  primarySwatch: Colors.red,
                                  colorScheme: const ColorScheme.light(
                                      primary: AppColor.primary,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black)));

                          if (_startWorkTime != null) {
                            setState(() {
                              _startWork.text = DateFormat("HH:mm").format(
                                  TimePickerUtil.convertTimeOfDayToDateTime(
                                      _startWorkTime!));
                            });
                          }
                        })
                  ],
                )),
                SizedBox(width: _spaceWidth),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(""),
                    SimpleOutlinedPickerInput(
                        readOnly: true,
                        controller: _endWork,
                        hintText: "selesai kerja",
                        onTap: () async {
                          _endWorkTime = await showRoundedTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              theme: ThemeData(
                                  primarySwatch: Colors.red,
                                  colorScheme: const ColorScheme.light(
                                      primary: AppColor.primary,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black)));

                          if (_endWorkTime != null) {
                            setState(() {
                              _endWork.text = DateFormat("HH:mm").format(
                                  TimePickerUtil.convertTimeOfDayToDateTime(
                                      _endWorkTime!));
                            });
                          }
                        })
                  ],
                )),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: SmallLoadingButton(
                text: "Cari Kandidat",
                loadingText: "Mencari Kandidat",
                isLoading: _isFindLoading,
                onPressed: () {
                  setState(() {
                    _validateWorkingDays();
                  });
                  if (_formKey.currentState!.validate() &&
                      _workingDaysErrorMessage == null) {
                    if (_isFindLoading) return;

                    setState(() => _isFindLoading = true);
                    _findCandidate();
                  } else {
                    FormUtil.showToast(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _storeCreateJobRequest(User user) {
    CreateJobRequest createJobRequest = CreateJobRequest(
        jobDescription: _jobDescription.text,
        jobType: _jobType,
        salary: _salary.text,
        salaryType: _salaryType!.value,
        educationQualifications: _educationQualification!.values,
        workingDays: _workingDays,
        workingHour: "${_startWork.text}-${_endWork.text}");

    _sultanRecruitmentProvider
        .storeCreateJobRequestToLocalStore(createJobRequest);
  }

  void _compareFindCandidateRequests(FindCandidateRequest findCandidateRequest) {
    if (_sultanRecruitmentProvider.findCandidateRequest == null) {
      _sultanRecruitmentProvider.findCandidateRequest = findCandidateRequest;
    } else {
      if (findCandidateRequest.experience !=
              _sultanRecruitmentProvider.findCandidateRequest!.experience ||
          findCandidateRequest.gender !=
              _sultanRecruitmentProvider.findCandidateRequest!.gender) {
        _sultanRecruitmentProvider.findCandidateRequest = findCandidateRequest;
        _sultanRecruitmentProvider.jobId = "";
      }
    }
  }

  void _findCandidate() async {
    try {
      User user = await _sultanRecruitmentProvider.fetchProfile();

      FindCandidateRequest findCandidateRequest = FindCandidateRequest(
          educationLevels: _educationQualification!.values,
          city: user.city,
          age: _age,
          experience: _profession!.name,
          gender: _gender);

      _storeCreateJobRequest(user);

      CandidateResponse candidateResponse =
          await _sultanRecruitmentProvider.findCandidates(findCandidateRequest);

      _compareFindCandidateRequests(findCandidateRequest);

      List<ProfileEmployeeResponse> candidates =
          candidateResponse.profileEmployees!;

      _sultanRecruitmentProvider.setProfileEmployeeResponses(candidates);

      PostActivityUseCase.exec(ActivityRequest(
          type: ActivityTypeUtil.webFindCandidate,
          extra: ActivityExtraRequest(
              state: "tap",
              screen: "sultan recruitment",
              widget: "cari kandidat")));

      _sultanRecruitmentProvider.findCandidate = FindCandidate(
          profession: _profession!,
          gender: _gender,
          age: _age,
          description: _jobDescription.text,
          educationQualification: _educationQualification!,
          jobType: _jobType,
          salary: _salary.text,
          salaryType: _salaryType!,
          workingDays: _workingDays,
          startWork: _startWork.text,
          endWork: _endWork.text);

      if (candidates.isNotEmpty) {
        _sultanRecruitmentProvider.pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        setState(() {
          _isFindLoading = false;
        });
        _showNotFoundCandidateDialog();
      }
    } catch (error) {
      setState(() {
        _isFindLoading = false;
      });
    }
  }

  void _showNotFoundCandidateDialog() {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                  content: SizedBox(
                    width: 400,
                    height: 350,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/not-found.png",
                              width: 400,
                              height: 200,
                            ),
                            const Heading4(
                              text:
                                  "Oops! Belum terdapat kandidat yang sesuai kriteria.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ParagraphWidget(
                              "Ayo cari kandidat dengan kriteria lain.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        style:
                            TextButton.styleFrom(primary: AppColor.secondary),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("OK"))
                  ],
                )));
  }

  void _initFindCandidatePreviousData() {
    FindCandidate? findCandidate =
        context.read<SultanRecruitmentProvider>().findCandidate;


    if (findCandidate != null) {
      _profession = findCandidate.profession;
      _jobDescription.text = findCandidate.description ?? "";
      _gender = findCandidate.gender;
      _age = findCandidate.age;
      _educationQualification = findCandidate.educationQualification;
      _jobType = findCandidate.jobType;
      _salary.text = findCandidate.salary;
      _salaryType = findCandidate.salaryType;
      _workingDays = [];
      _startWork.text = findCandidate.startWork;
      _endWork.text = findCandidate.endWork;
    }
  }

  void _validateWorkingDays() {
    if (_workingDays == null || _workingDays!.isEmpty) {
      _workingDaysErrorMessage = "Mohon pilih hari kerja";
    } else {
      _workingDaysErrorMessage = null;
    }
  }
}
