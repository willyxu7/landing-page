import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/domain/entities/job_role.dart';
import 'package:kukerja_web/core/providers/job_role_provider.dart';
import 'package:kukerja_web/core/providers/user_provider.dart';
import 'package:kukerja_web/core/widgets/small_loading_icon_button.dart';
import 'package:kukerja_web/features/kukerja/freetalent/data/models/requests/create_freetalent_employer_request.dart';
import 'package:kukerja_web/features/kukerja/freetalent/domain/usecases/freetalent_employer_use_case.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/providers/freetalent_employer_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/utils/date_picker_util.dart';
import '../../../../../../../core/utils/form_util.dart';
import '../../../../../../../core/utils/time_picker_util.dart';
import '../../../../../../../core/widgets/heading_2.dart';
import '../../../../../../../core/widgets/simple_outlined_dropdown_search.dart';
import '../../../../../../../core/widgets/simple_outlined_picker_input.dart';
import '../../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../landing_page/style/app_color.dart';

class FreetalentEmployerFormDesktopWidget extends StatefulWidget {
  final TextEditingController addressController,
      descriptionController,
      workingDaysController,
      workingHoursController,
      scheduleNoteController;

  TextEditingController workingTimeController,
      startWorkingHourController,
      endWorkingHourController;

  final GlobalKey<FormState> formKey;

  FreetalentEmployerFormDesktopWidget(
      {required this.addressController,
      required this.descriptionController,
      required this.workingDaysController,
      required this.workingTimeController,
      required this.workingHoursController,
      required this.scheduleNoteController,
      required this.startWorkingHourController,
      required this.endWorkingHourController,
      required this.formKey,
      Key? key})
      : super(key: key);

  @override
  State<FreetalentEmployerFormDesktopWidget> createState() =>
      _FreetalentEmployerFormDesktopWidgetState();
}

class _FreetalentEmployerFormDesktopWidgetState
    extends State<FreetalentEmployerFormDesktopWidget> {
  final FreetalentEmployerUseCase _freetalentEmployerUseCase =
      FreetalentEmployerUseCase();

  // final UserUseCase _userUseCase = UserUseCase(UserRepositoryImpl());

  DateTime _selectedWorkingTime = DateTime.now();
  List<String> _selectedWorkDays = [];

  bool _buttonLoading = false;

  Future<void> _create() async {
    CreateFreetalentEmployerRequest createFreetalentEmployerRequest =
        CreateFreetalentEmployerRequest(
            createUserRequest: context.read<UserProvider>().createUserRequest,
            address: widget.addressController.text,
            description: widget.descriptionController.text,
            endWorkingHour: widget.endWorkingHourController.text,
            role: context.read<JobRoleProvider>().selectedJobRole,
            scheduleNote: widget.scheduleNoteController.text,
            startWorkingHour: widget.startWorkingHourController.text,
            workingDays: _selectedWorkDays,
            workingTime: _selectedWorkingTime.toString());

    await _freetalentEmployerUseCase.create(createFreetalentEmployerRequest);

    // _userUseCase.create(context.read<UserProvider>().createUserRequest);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading2(text: 'Informasi Lowongan'),
              const SizedBox(height: 16),
              TextButton.icon(
                  style: TextButton.styleFrom(primary: AppColor.secondary),
                  onPressed: () {
                    context
                        .read<FreetalentEmployerProvider>()
                        .pageController
                        .previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 12,
                  ),
                  label: const Text('Kembali')),
              const SizedBox(height: 16),
              const Text('Rincian Pekerjaan'),
              SimpleOutlinedTextArea(
                  controller: widget.descriptionController,
                  hintText: 'jelaskan persyaratan pekerjaan'),
              const Text('Alamat Lengkap'),
              SimpleOutlinedTextArea(
                  controller: widget.addressController,
                  hintText: 'masukkan alamat kantor anda'),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Profesi'),
                      SimpleOutlinedDropdownSearch<JobRole>(
                          hintText: 'pilih profesi',
                          items: context.watch<JobRoleProvider>().jobRoles,
                          itemAsString: (JobRole? jobRole) =>
                              jobRole!.labels['id']!,
                          onChanged: (JobRole jobRole) {
                            context.read<JobRoleProvider>().selectedJobRole =
                                jobRole.name;
                          }),
                    ],
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tanggal Kehadiran'),
                      SimpleOutlinedPickerInput(
                        controller: widget.workingTimeController,
                        hintText: 'pilih tanggal kehadiran',
                        onTap: () async {
                          final DateTime? selectedDate =
                              await DatePickerUtil.selectWorkingTime(context);
                          if (selectedDate != null &&
                              selectedDate != _selectedWorkingTime) {
                            setState(() {
                              _selectedWorkingTime = selectedDate;
                              widget.workingTimeController.text = DatePickerUtil
                                  .convertToIndonesianDateWithWeekday(
                                      _selectedWorkingTime);
                            });
                          }
                        },
                      ),
                    ],
                  ))
                ],
              ),
              const Text('Jam Kerja'),
              Row(
                children: [
                  Expanded(
                      child: SimpleOutlinedPickerInput(
                    controller: widget.startWorkingHourController,
                    hintText: 'mulai kerja',
                    onTap: () {
                      setState(() {
                        TimePickerUtil.picker(context).then(
                            (selectedStartWorkingHour) => widget
                                    .startWorkingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                      });
                    },
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: SimpleOutlinedPickerInput(
                    controller: widget.endWorkingHourController,
                    hintText: 'selesai kerja',
                    onTap: () {
                      setState(() {
                        TimePickerUtil.picker(context).then(
                            (selectedStartWorkingHour) => widget
                                    .endWorkingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                      });
                    },
                  )),
                ],
              ),
              const Text('Pilih Hari Kerja'),
              ChipsChoice<String>.multiple(
                value: _selectedWorkDays,
                onChanged: (val) => setState(() => _selectedWorkDays = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  source: FormUtil.days,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceStyle: const C2ChoiceStyle(
                  color: AppColor.secondary,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(4),
                  borderOpacity: .3,
                ),
                choiceActiveStyle: const C2ChoiceStyle(
                  color: AppColor.secondary,
                  brightness: Brightness.dark,
                ),
                wrapped: true,
              ),
              const Text('Keterangan Tambahan'),
              SimpleOutlinedTextArea(
                  controller: widget.scheduleNoteController,
                  optional: true,
                  hintText:
                      'keterangan jika ada jadwal off tertentu (opsional)'),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: SmallLoadingIconButton(
                    text: 'Ajukan Freetalent',
                    icon: const Icon(FontAwesomeIcons.paperPlane, size: 14),
                    isLoading: _buttonLoading,
                    onPress: () async {
                      if (widget.formKey.currentState!.validate()) {
                        setState(() {
                          _buttonLoading = true;
                        });

                        await _create();

                        context
                            .read<FreetalentEmployerProvider>()
                            .pageController
                            .nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
