import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/widgets/information_dialog.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/selected_candidate_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/requests/send_bulk_interview_request.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/responses/send_interview_response.dart';
import 'package:kukerja_web/features/kukerja/sultan/data/models/selected_candidate.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/widgets/items/candidate_card.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/responsive.dart';
import '../../../../../../core/utils/time_picker_util.dart';
import '../../../../../../core/widgets/simple_outlined_picker_input.dart';
import '../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../core/widgets/small_loading_button.dart';
import '../../../../../../core/widgets/small_outline_button.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../providers/sultan_recruitment_provider.dart';
import 'selected_candidate_card.dart';

class ShowCandidate extends StatefulWidget {
  const ShowCandidate({Key? key}) : super(key: key);

  @override
  State<ShowCandidate> createState() => _ShowCandidateState();
}

class _ShowCandidateState extends State<ShowCandidate> {
  bool _isSentInterview = false;
  late SultanRecruitmentProvider _sultanRecruitmentProvider;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController _interviewLocation = TextEditingController();

  String? _userId;
  TimeOfDay? _pickedTime;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _fetchFromLocalStorage();
  }

  @override
  void dispose() {
    super.dispose();
    _interviewLocation.dispose();
  }

  void _fetchFromLocalStorage() async {
    _userId = await _storage.read(key: "id");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    _sultanRecruitmentProvider = context.watch<SultanRecruitmentProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kirim Wawancara",
                      style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                  Text(
                      "${_sultanRecruitmentProvider.selectedCandidates.length} / 5 kandidat terpilih")
                ],
              )),
              SmallButton(
                text: "Kirim",
                onPressed:
                    (_sultanRecruitmentProvider.selectedCandidates.isEmpty)
                        ? null
                        : () {
                            _showLocationFormDialog();
                          },
                buttonSize: const Size(50, 40),
              )
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            height: (_sultanRecruitmentProvider.selectedCandidates.isEmpty)
                ? 30
                : 180,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sultanRecruitmentProvider.selectedCandidates
                      .map((candidate) => SelectedCandidateCard(
                            id: candidate.id,
                            name: candidate.name,
                            profilePhotoPath: candidate.profilePhotoPath,
                            interviewDate: DatePickerUtil
                                .convertToIndonesianDateWithWeekday(
                                    candidate.interviewDate!),
                            interviewTime: DateFormat("HH:mm").format(
                                TimePickerUtil.convertTimeOfDayToDateTime(
                                    candidate.interviewTime!)),
                            onRemoved: (String id) {
                              _sultanRecruitmentProvider
                                  .removeSelectedCandidatesById(id);
                            },
                            onTap: () {
                              _showInterviewFormDialog(
                                  context, candidate.id, candidate);
                            },
                          ))
                      .toList()),
            ),
          ),
          const Text("Kandidat",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary)),
          Column(
            children: _sultanRecruitmentProvider.profileEmployeeResponses
                .map((profileEmployee) => CandidateCard(
                      name: profileEmployee.name,
                      profilePhotoPath: profileEmployee.imageProfileUrl,
                      lastEducation: profileEmployee.educations![0].level,
                      lastJobExperience: profileEmployee.experiences!.isNotEmpty
                          ? '${profileEmployee.experiences![0].position} di ${profileEmployee.experiences![0].companyName}'
                          : "Belum memiliki pengalaman",
                      age: profileEmployee.age,
                      onTap: () {
                        _showInterviewFormDialog(context, profileEmployee.id);
                      },
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                  child: SmallOutlineButton(
                text: "Ganti Kriteria",
                borderColor: AppColor.secondary,
                primaryColor: AppColor.secondary,
                fontSize: 16,
                onPressed: () {
                  context
                      .read<SultanRecruitmentProvider>()
                      .pageController
                      .previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);

                  _sultanRecruitmentProvider.clearSelectedCandidates();
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: SmallButton(
                text: "Hubungi Kami",
                onPressed: () {
                  KukerjaEnv.launchKukerjaWaLink();
                },
              )),
            ],
          ),
          const SizedBox(height: 24),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount:
          //         _sultanRecruitmentProvider.profileEmployeeResponses.length,
          //     itemBuilder: (_, index) {
          //       var profileEmployee =
          //           _sultanRecruitmentProvider.profileEmployeeResponses[index];
          //       return CandidateCard(
          //         name: profileEmployee.name,
          //         profilePhotoPath: profileEmployee.imageProfileUrl,
          //         lastEducation: profileEmployee.educations![0].level,
          //         lastJobExperience: profileEmployee.experiences!.isNotEmpty
          //             ? '${profileEmployee.experiences![0].position} di ${profileEmployee.experiences![0].companyName}'
          //             : "Belum memiliki pengalaman",
          //         age: _sultanRecruitmentProvider
          //             .profileEmployeeResponses[index].age,
          //         onTap: () {
          //           showInterviewFormDialog(context, profileEmployee.id);
          //         },
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Future<dynamic> _showInterviewFormDialog(
      BuildContext context, String employeeId,
      [SelectedCandidate? selectedCandidate]) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController interviewTime = TextEditingController();
    TextEditingController interviewDate = TextEditingController();
    bool isConfirm = false;

    if (selectedCandidate != null) {
      interviewDate.text = DatePickerUtil.convertToIndonesianDateWithWeekday(
          selectedCandidate.interviewDate!);
      interviewTime.text = DateFormat("HH:mm").format(
          TimePickerUtil.convertTimeOfDayToDateTime(
              selectedCandidate.interviewTime!));
    }

    return await showDialog(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
            builder: (builder, setState) => AlertDialog(
                    content: SizedBox(
                      width: 450,
                      height: 200,
                      child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Waktu dan Tanggal Wawancara"),
                              SimpleOutlinedPickerInput(
                                readOnly: true,
                                controller: interviewTime,
                                hintText: "pilih jam wawancara",
                                onTap: () async {
                                  _pickedTime = await showRoundedTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      theme: ThemeData(
                                          primarySwatch: Colors.red,
                                          colorScheme: const ColorScheme.light(
                                              primary: AppColor.primary,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.black)));

                                  if (_pickedTime != null) {
                                    setState(() {
                                      interviewTime.text = DateFormat("HH:mm")
                                          .format(TimePickerUtil
                                              .convertTimeOfDayToDateTime(
                                                  _pickedTime!));
                                    });
                                  }
                                },
                              ),
                              SimpleOutlinedPickerInput(
                                  readOnly: true,
                                  controller: interviewDate,
                                  hintText: "pilih tanggal wawancara",
                                  onTap: () async {
                                    _selectedDate = await showDatePicker(
                                      context: dialogContext,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 356)),
                                      builder: (context, child) {
                                        return Center(
                                          child: Theme(
                                            data: ThemeData(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                        primary:
                                                            AppColor.primary,
                                                        onPrimary: Colors.white,
                                                        onSurface:
                                                            Colors.black)),
                                            child: Center(
                                              child: SizedBox(
                                                height: 450,
                                                width: 700,
                                                child: child,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    if (_selectedDate != null) {
                                      setState(() {
                                        interviewDate.text =
                                            DateFormat.yMMMMd('idr')
                                                .format(_selectedDate!);
                                      });
                                    }
                                  })
                            ],
                          )),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      SmallLoadingButton(
                          isLoading: isConfirm,
                          buttonSize: (ResponsiveWidget.isSmallScreen(context))
                              ? const Size.fromHeight(50)
                              : const Size(190, 50),
                          text: "Konfirmasi",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (isConfirm) return;

                              setState(() => isConfirm = true);

                              if (selectedCandidate == null) {
                                var profileEmployee = _sultanRecruitmentProvider
                                    .profileEmployeeResponses
                                    .firstWhere((profileEmployee) =>
                                        profileEmployee.id == employeeId);

                                SelectedCandidate newSelectedCandidate =
                                    SelectedCandidate(
                                        id: employeeId,
                                        name: profileEmployee.name,
                                        profilePhotoPath:
                                            profileEmployee.imageProfileUrl,
                                        interviewDate: _selectedDate!,
                                        interviewTime: _pickedTime!);

                                _addSelectedCandidate(
                                    newSelectedCandidate, employeeId);
                              } else {
                                selectedCandidate.interviewDate = _selectedDate!;
                                selectedCandidate.interviewTime = _pickedTime!;

                                _sultanRecruitmentProvider
                                    .updateSelectedCandidate(selectedCandidate);

                                if (!mounted) return;
                                Navigator.pop(context);
                              }
                            }
                          }),
                      (ResponsiveWidget.isSmallScreen(context))
                          ? const SizedBox(height: 20)
                          : const SizedBox(width: 16),
                      SmallOutlineButton(
                          buttonSize: (ResponsiveWidget.isSmallScreen(context))
                              ? const Size.fromHeight(50)
                              : const Size(190, 50),
                          text: "Batal",
                          primaryColor: AppColor.secondary,
                          borderColor: AppColor.secondary,
                          onPressed: () => Navigator.pop(context)),
                    ])));
  }

  void _showLocationFormDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (builder, setState) => AlertDialog(
              content: SizedBox(
                width: 450,
                height: 200,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text("Lokasi Wawancara"),
                      SimpleOutlinedTextArea(
                          maxLength: 255,
                          controller: _interviewLocation,
                          hintText: "masukkan lokasi wawancara secara rinci")
                    ],
                  ),
                ),
              ),
              actions: [
                SmallLoadingButton(
                    buttonSize: const Size.fromHeight(40),
                    text: "Kirim",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (_isSentInterview) return;

                        setState(() => _isSentInterview = true);

                        _sendBulkInterview();
                      }
                    },
                    isLoading: _isSentInterview)
              ],
            ),
          );
        });
  }

  Future<dynamic> _addSelectedCandidate(
      SelectedCandidate newSelectedCandidate, String employeeId) async {
    if (_sultanRecruitmentProvider.selectedCandidates.length == 5) {
      Navigator.pop(context);
      return await showDialog(
          context: context,
          builder: (builder) => const InformationDialog(
                title: "Informasi",
                description: "Telah melebihi kapasitas 5 kandidat",
              ));
    } else {
      _sultanRecruitmentProvider.addSelectedCandidates(newSelectedCandidate);

      _sultanRecruitmentProvider.removeProfileEmployeeResponsesById(employeeId);
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  void _sendBulkInterview() async {
    SendBulkInterviewRequest sendBulkInterviewRequest =
        SendBulkInterviewRequest(
            employees: _sultanRecruitmentProvider.selectedCandidates
                .map((selectedCandidate) => SelectedCandidateRequest(
                    userId: selectedCandidate.id,
                    interviewDate: selectedCandidate.interviewDate,
                    interviewTime: selectedCandidate.interviewTime))
                .toList(),
            employerId: _userId!,
            location: _interviewLocation.text,
            findCandidateRequest:
                _sultanRecruitmentProvider.findCandidateRequest!);

    SendInterviewResponse sendInterviewResponse =
        await _sultanRecruitmentProvider.sendBulkInterview(
            _sultanRecruitmentProvider.jobId, sendBulkInterviewRequest);

    if (sendInterviewResponse.jobId.isNotEmpty) {
      _sultanRecruitmentProvider.jobId = sendInterviewResponse.jobId;
      setState(() => _isSentInterview = false);
      if (!mounted) return;
      Navigator.pop(context);
      _sultanRecruitmentProvider.pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }
}
