import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/responsive.dart';
import '../../../../../../core/config/size_config.dart';
import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/utils/time_picker_util.dart';
import '../../../../../../core/widgets/simple_outlined_picker_input.dart';
import '../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../core/widgets/small_button.dart';
import '../../../../../../core/widgets/small_loading_button.dart';
import '../../../../../../core/widgets/small_outline_button.dart';
import '../../../../../../core/widgets/success_dialog.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../landing_page/style/app_color.dart';
import '../../../../recruitment/presentation/widgets/recommendations/items/recommendation_card_widget.dart';
import '../../../data/models/requests/send_interview_request.dart';
import '../../../data/models/responses/send_interview_response.dart';
import '../../providers/sultan_recruitment_provider.dart';

@Deprecated("Use `ShowCandidate` instead")
class ShowCandidateMobile extends StatefulWidget {
  const ShowCandidateMobile({Key? key}) : super(key: key);

  @override
  State<ShowCandidateMobile> createState() => _ShowCandidateMobileState();
}

class _ShowCandidateMobileState extends State<ShowCandidateMobile> {
  late SultanRecruitmentProvider _sultanRecruitmentProvider;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _userId;
  TimeOfDay? _pickedTime;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _fetchFromLocalStorage();
  }

  void _fetchFromLocalStorage() async {
    _userId = await _storage.read(key: "id");
  }

  List<Widget> _initCandidateWidgets(BuildContext context) {
    return context
        .watch<SultanRecruitmentProvider>()
        .profileEmployeeResponses
        .map((profileEmployee) {
      return (RecommendationCardWidget(
        id: profileEmployee.id,
        profilePhotoPath: profileEmployee.imageProfileUrl,
        name: profileEmployee.name,
        age: profileEmployee.age,
        lastJobExperience: (profileEmployee.experiences!.isNotEmpty)
            ? '${profileEmployee.experiences![0].position} di ${profileEmployee.experiences![0].companyName}'
            : "Belum memiliki pengalaman",
        lastEducation: 'Pendidikan ${profileEmployee.educations![0].level}',
        width: 200,
        avatarRadius: 40,
        link: profileEmployee.link,
        onAvaTapped: () {
          PostActivityUseCase.exec(ActivityRequest(
              type: ActivityTypeUtil.webSeeProfilePicture,
              extra: ActivityExtraRequest(
                  widget: 'circle avatar',
                  screen: 'sultan recruitment',
                  state: 'tap'),
              detail: profileEmployee.id));
        },
        buttonText: "Wawancara",
        onProfilePressed: () {
          _showInterviewFormDialog(context, profileEmployee.id);
          PostActivityUseCase.exec(ActivityRequest(
              detail: profileEmployee.id,
              type: ActivityTypeUtil.webSeeProfile,
              extra: ActivityExtraRequest(
                state: 'tap',
                widget: 'profile',
                screen: 'sultan recruitment',
                userId: profileEmployee.id,
              )));
          if (kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
            KukerjaEnv.launchJobSeekerProfile(profileEmployee.link);
          } else if (kIsWeb &&
              defaultTargetPlatform == TargetPlatform.windows &&
              defaultTargetPlatform == TargetPlatform.macOS) {
            KukerjaEnv.launchRecommendedWebLink();
          }
        },
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _sultanRecruitmentProvider = context.watch<SultanRecruitmentProvider>();

    return Container(
      padding: const EdgeInsets.only(top: 24, left: 4, right: 4, bottom: 24),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 48, bottom: 8),
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isSmallScreen(context) ? 16 : 80),
          child: Column(
            children: [
              Text(
                'Hasil pencarian dari 1-${context.watch<SultanRecruitmentProvider>().profileEmployeeResponses.length} kandidat',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Wrap(
            spacing: 8,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [..._initCandidateWidgets(context)]),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SmallButton(
                  text: "Hubungi Kami",
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Future<dynamic> _showInterviewFormDialog(
      BuildContext context, String employeeId) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController interviewLocation = TextEditingController();
    TextEditingController interviewTime = TextEditingController();
    TextEditingController interviewDate = TextEditingController();
    bool isSentInterview = false;

    List<String> employeeIds = [employeeId];

    return await showDialog(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
            builder: (builder, setState) => AlertDialog(
                  content: SizedBox(
                    width: 600,
                    height: 300,
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Lokasi Wawancara"),
                            SimpleOutlinedTextArea(
                                controller: interviewLocation,
                                hintText:
                                    "masukkan lokasi wawancara secara rinci"),
                            const Text("Waktu dan Tanggal Wawancara"),
                            Row(
                              children: [
                                Expanded(
                                    child: SimpleOutlinedPickerInput(
                                  readOnly: true,
                                  controller: interviewTime,
                                  hintText: "pilih jam wawancara",
                                  onTap: () async {
                                    _pickedTime = await showRoundedTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        theme: ThemeData(
                                            primarySwatch: Colors.red,
                                            colorScheme:
                                                const ColorScheme.light(
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
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: SimpleOutlinedPickerInput(
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
                                                          const ColorScheme
                                                                  .light(
                                                              primary: AppColor
                                                                  .primary,
                                                              onPrimary:
                                                                  Colors.white,
                                                              onSurface: Colors
                                                                  .black)),
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
                                        }))
                              ],
                            )
                          ],
                        )),
                  ),
                  actions: ResponsiveWidget.isSmallScreen(context)
                      ? [
                          SmallLoadingButton(
                              isLoading: isSentInterview,
                              buttonSize: const Size.fromHeight(50),
                              text: "Kirim Wawancara",
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (isSentInterview) return;

                                  setState(() => isSentInterview = true);

                                  String jobId =
                                      _sultanRecruitmentProvider.jobId;

                                  SendInterviewResponse sendInterviewResponse =
                                      await _sultanRecruitmentProvider
                                          .sendInterview(
                                              jobId,
                                              SendInterviewRequest(
                                                  employeeIds: employeeIds,
                                                  employerId: _userId!,
                                                  interviewLocation:
                                                      interviewLocation.text,
                                                  interviewTime: _pickedTime,
                                                  interviewDate: _selectedDate,
                                                  findCandidateRequest:
                                                      _sultanRecruitmentProvider
                                                          .findCandidateRequest!));

                                  PostActivityUseCase.exec(ActivityRequest(
                                      detail: employeeIds.first,
                                      type: ActivityTypeUtil.webSendInterview,
                                      extra: ActivityExtraRequest(
                                          state: 'tap',
                                          widget: 'profile',
                                          screen: 'candidate')));

                                  if (!mounted) return;
                                  Navigator.pop(context);

                                  if (!sendInterviewResponse.jobId.isNotEmpty) {
                                    _sultanRecruitmentProvider.jobId =
                                        sendInterviewResponse.jobId;
                                    setState(() => isSentInterview = false);
                                    showDialog(
                                        context: context,
                                        builder: (builder) => SuccessDialog(
                                            title: "Berhasil",
                                            description:
                                                "Yuk kirim wawancara lagi.",
                                            onPressed: () {}));
                                  }
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
                          SmallLoadingButton(
                              isLoading: isSentInterview,
                              text: "Kirim Wawancara",
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (isSentInterview) return;

                                  setState(() => isSentInterview = true);

                                  String jobId =
                                      _sultanRecruitmentProvider.jobId;

                                  SendInterviewResponse sendInterviewResponse =
                                      await _sultanRecruitmentProvider
                                          .sendInterview(
                                              jobId,
                                              SendInterviewRequest(
                                                  employeeIds: employeeIds,
                                                  employerId: _userId!,
                                                  interviewLocation:
                                                      interviewLocation.text,
                                                  interviewTime: _pickedTime,
                                                  interviewDate: _selectedDate,
                                                  findCandidateRequest:
                                                      _sultanRecruitmentProvider
                                                          .findCandidateRequest!));

                                  PostActivityUseCase.exec(ActivityRequest(
                                      detail: employeeIds.first,
                                      type: ActivityTypeUtil.webSendInterview,
                                      extra: ActivityExtraRequest(
                                          state: 'tap',
                                          widget: 'profile',
                                          screen: 'candidate')));

                                  if (!mounted) return;
                                  Navigator.pop(context);

                                  if (!sendInterviewResponse.jobId.isNotEmpty) {
                                    _sultanRecruitmentProvider.jobId =
                                        sendInterviewResponse.jobId;
                                    setState(() => isSentInterview = false);
                                    showDialog(
                                        context: context,
                                        builder: (builder) => SuccessDialog(
                                            title: "Berhasil",
                                            description:
                                                "Yuk kirim wawancara lagi.",
                                            onPressed: () {}));
                                  }
                                }
                              })
                        ],
                )));
  }
}
