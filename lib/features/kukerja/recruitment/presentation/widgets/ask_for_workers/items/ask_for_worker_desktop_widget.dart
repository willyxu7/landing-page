import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/widgets/simple_outlined_dropdown_button.dart';
import '../../../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../landing_page/style/app_color.dart';
import '../../../../data/models/request/ask_for_worker_request.dart';
import '../../../providers/ask_for_worker_provider.dart';

class AskForWorkerDesktopWidget extends StatefulWidget {
  final TextEditingController employerNameController,
      jobTitleController,
      criteriaController,
      qualificationController,
      phoneNumberController;
  final GlobalKey<FormState> formKey;

  AskForWorkerDesktopWidget(
      {required this.employerNameController,
      required this.jobTitleController,
      required this.criteriaController,
      required this.qualificationController,
      required this.phoneNumberController,
      required this.formKey,
      Key? key})
      : super(key: key);

  @override
  State<AskForWorkerDesktopWidget> createState() =>
      _AskForWorkerDesktopWidgetState();
}

class _AskForWorkerDesktopWidgetState extends State<AskForWorkerDesktopWidget> {
  void postAskForWorker() {
    AskForWorkerRequest askForWorkerRequest = AskForWorkerRequest(
        employerName: widget.employerNameController.text,
        jobTitle: widget.jobTitleController.text,
        criteria: widget.criteriaController.text,
        qualification: widget.qualificationController.text,
        gender: context.read<AskForWorkerProvider>().selectedGender,
        age: context.read<AskForWorkerProvider>().selectedAge,
        educationQualification:
            context.read<AskForWorkerProvider>().selectedEducationQualification,
        selectedLocation:
            context.read<AskForWorkerProvider>().selectedLocation);

    context.read<AskForWorkerProvider>().postAskForWorker(askForWorkerRequest);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: 640,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nama Usaha'),
                      SimpleOutlinedTextInput(
                          controller: widget.employerNameController,
                          hintText: 'nama usaha anda'),
                    ],
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nomor Handphone'),
                      SimpleOutlinedTextInput(
                          controller: widget.phoneNumberController,
                          hintText: 'nomor handphone yang aktif'),
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
                      const Text('Lowongan'),
                      SimpleOutlinedTextInput(
                          controller: widget.jobTitleController,
                          hintText: 'judul lowongan'),
                    ],
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Industri'),
                      SimpleOutlinedDropdownButton(
                          items:
                              context.watch<AskForWorkerProvider>().industries,
                          hint: 'pilih industri',
                          onChanged: () {}),
                    ],
                  ))
                ],
              ),
              const Text('Kriteria'),
              SimpleOutlinedTextArea(
                  controller: widget.criteriaController, hintText: 'Kriteria'),
              const Text('Syarat Khusus'),
              SimpleOutlinedTextArea(
                  controller: widget.qualificationController,
                  hintText: 'Cantumkan syarat khusus'),
              Row(
                children: [
                  // Expanded(
                  //     child: Column(
                  //   children: [
                  //     const Text('Lokasi'),
                  //     SimpleOutlinedDropdownButton(
                  //       items: context.watch<AskForWorkerProvider>().locations,
                  //       hint: 'pilih lokasi pekerjaan',
                  //       onChanged: (value) {
                  //         context
                  //             .read<AskForWorkerProvider>()
                  //             .setSelectedLocation(value);
                  //       },
                  //     ),
                  //   ],
                  // )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Lokasi'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                            ),
                            items: context.watch<AskForWorkerProvider>().cities,
                            onChanged: (value) {
                              context
                                  .read<AskForWorkerProvider>()
                                  .setSelectedLocation(value.toString());
                            },
                            dropdownButtonProps: const IconButtonProps(
                              icon: Icon(
                                FontAwesomeIcons.angleDown,
                                color: Colors.grey,
                              ),
                            ),
                            dropdownSearchDecoration: const InputDecoration(
                                hintText: 'pilih lokasi',
                                focusColor: AppColor.secondary,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.secondary, width: 2)))),
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pendidikan'),
                      SimpleOutlinedDropdownButton(
                        items: context
                            .watch<AskForWorkerProvider>()
                            .educationQualifications,
                        hint: 'pilih syarat pendidikan',
                        onChanged: (value) {
                          context
                              .read<AskForWorkerProvider>()
                              .setSelectedEducationQualification(value);
                        },
                      ),
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
                        const Text('Jenis Kelamin'),
                        SimpleOutlinedDropdownButton(
                          items: context.watch<AskForWorkerProvider>().genders,
                          hint: 'pilih jenis kelamin',
                          onChanged: (value) {
                            context
                                .read<AskForWorkerProvider>()
                                .setSelectedGender(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Umur'),
                        SimpleOutlinedDropdownButton(
                          items: context.watch<AskForWorkerProvider>().ages,
                          hint: 'pilih umur',
                          onChanged: (value) {
                            context
                                .read<AskForWorkerProvider>()
                                .setSelectedAge(value);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: AppColor.secondary),
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        postAskForWorker();
                      }
                    },
                    child: const Text(
                      'Ajukan Dicarikan Karyawan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
