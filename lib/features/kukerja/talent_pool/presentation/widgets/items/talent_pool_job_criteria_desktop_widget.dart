import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/exceptions/internal_server_error_exception.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_button.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_picker_input.dart';
import 'package:kukerja_web/core/widgets/small_loading_button.dart';
import 'package:kukerja_web/core/widgets/styled_multi_select_chip.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_job_criteria_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_job_criteria_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/talent_pool_terms.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../core/utils/form_util.dart';
import '../../../../../../core/utils/time_picker_util.dart';
import '../../../../../../core/widgets/heading_3.dart';
import '../../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../../core/widgets/small_text_icon_button.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';
import '../../../../landing_page/style/app_color.dart';
import '../../../data/models/requests/create_talent_pool_contract_request.dart';

class TalentPoolJobCriteriaDesktopWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberController,
      startWorkingHourController,
      endWorkingHourController,
      startStudyingHourController,
      endStudyingHourController;

  const TalentPoolJobCriteriaDesktopWidget(
      {required this.formKey,
      required this.phoneNumberController,
      required this.startWorkingHourController,
      required this.endWorkingHourController,
      required this.startStudyingHourController,
      required this.endStudyingHourController,
      Key? key})
      : super(key: key);

  @override
  State<TalentPoolJobCriteriaDesktopWidget> createState() =>
      _TalentPoolJobCriteriaDesktopWidgetState();
}

class _TalentPoolJobCriteriaDesktopWidgetState
    extends State<TalentPoolJobCriteriaDesktopWidget> {
  final SignatureController _signatureController = SignatureController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  late TalentPoolProvider _talentPoolProvider;

  Uint8List? _uploadedSignaturePhoto;

  bool _isHaveVehicle = false,
      _isVaccinated = false,
      _isHaveSkck = false,
      _isReadyIntern = false,
      _isStillWorking = false,
      _isStillStudying = false;

  List<String> _selectedPlatforms = [],
      _selectedDriveLicenses = [],
      _selectedIndustries = [],
      _selectedProfessions = [];

  String _typeJob = "", _locationType = "";

  String? _platformErrorMessage, _industryErrorMessage, _imagesErrorMessage;

  List<PlatformFile>? _uploadedImages;
  List<String> _base64UploadedImages = [];

  final int _industryMax = 3, _professionMax = 3;
  static const double _space = 20;

  final List<MultiSelectCard> _platforms = [
        MultiSelectCard(value: 'GSM', label: 'GSM'),
        MultiSelectCard(value: 'Whatsapp', label: 'Whatsapp'),
        MultiSelectCard(value: 'Telegram', label: 'Telegram'),
        MultiSelectCard(
            value: 'Facebook Messenger', label: 'Facebook Messenger'),
      ],
      _driveLicenses = [
        MultiSelectCard(value: 'SIM A', label: 'SIM A'),
        MultiSelectCard(value: 'SIM B', label: 'SIM B'),
        MultiSelectCard(value: 'SIM B1', label: 'SIM B1'),
        MultiSelectCard(value: 'SIM B2', label: 'SIM B2'),
        MultiSelectCard(value: 'SIM C', label: 'SIM C'),
        MultiSelectCard(value: 'SIM D', label: 'SIM D'),
      ];

  @override
  initState() {
    super.initState();
    _talentPoolProvider = context.read<TalentPoolProvider>();

    _signatureController.onDrawEnd = () {
      _talentPoolProvider.isSignatureEmpty(_signatureController);
    };

    PostActivityUseCase.exec(
      ActivityRequest(type: ActivityTypeUtil.webViewJobCriteriaForm),
    );

    _fetchDataFromJobSeeker();

    // if (widget.phoneNumberController.text.isEmpty) {
    //   widget.phoneNumberController.text =
    //       context.read<TalentPoolProvider>().talentPoolCVResponse.phoneNumber;
    // }

    // _getAccessToken();

    // widget.phoneNumberController.text = "+628111111111";
  }

  Future<void> _fetchDataFromJobSeeker() async {
    TalentPoolJobCriteriaResponse? jobCriteria;

    String? userId = await _storage.read(key: "id");
    String? phoneNumber = await LocalStorageUtil.readPhoneNumber();

    if (widget.phoneNumberController.text.isEmpty) {
      widget.phoneNumberController.text = phoneNumber!;
    }

    if (userId != null) {
      jobCriteria = await _talentPoolProvider.fetchJobCriteriaByUserId(userId);

      if (jobCriteria != null) {
        _showTalentPoolTerms();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _talentPoolProvider = context.watch<TalentPoolProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Heading3(text: "Talent Pool Job Criteria"),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nomor handphone aktif"),
                    SimpleOutlinedTextInput(
                        optional: true,
                        readOnly: true,
                        controller: widget.phoneNumberController,
                        hintText: "masukkan nomor handphone aktif")
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
                    const Text("Tipe pekerjaan"),
                    SimpleOutlinedDropdownButton(
                      items: const ["Full time", "Paruh Waktu", "Bebas"],
                      hint: "pilih tipe kerja",
                      onChanged: (value) {
                        setState(() {
                          _typeJob = value;
                        });
                      },
                    )
                  ],
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tipe lokasi"),
                    SimpleOutlinedDropdownButton(
                      items: const ["Dalam Kota", "Luar Kota", "Bebas"],
                      hint: "pilih tipe lokasi",
                      onChanged: (value) {
                        setState(() {
                          _locationType = value;
                        });
                      },
                    )
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
                    const Text("Mempunyai kendaraan sendiri?"),
                    Row(
                      children: [
                        Flexible(
                            child: Radio<bool>(
                          value: true,
                          groupValue: _isHaveVehicle,
                          onChanged: (value) {
                            setState(() {
                              _isHaveVehicle = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Ya")),
                        const SizedBox(width: 10),
                        Flexible(
                            child: Radio<bool>(
                          value: false,
                          groupValue: _isHaveVehicle,
                          onChanged: (value) {
                            setState(() {
                              _isHaveVehicle = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Tidak")),
                      ],
                    )
                  ],
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
                    const Text("Sudah divaksin COVID19?"),
                    Row(
                      children: [
                        Flexible(
                            child: Radio<bool>(
                          value: true,
                          groupValue: _isVaccinated,
                          onChanged: (value) {
                            setState(() {
                              _isVaccinated = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Ya")),
                        const SizedBox(width: 10),
                        Flexible(
                            child: Radio<bool>(
                          value: false,
                          groupValue: _isVaccinated,
                          onChanged: (value) {
                            setState(() {
                              _isVaccinated = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Tidak")),
                      ],
                    )
                  ],
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
                    const Text("Ada Surat Keterangan Catatan Kepolisian?"),
                    Row(
                      children: [
                        Flexible(
                            child: Radio<bool>(
                          value: true,
                          groupValue: _isHaveSkck,
                          onChanged: (value) {
                            setState(() {
                              _isHaveSkck = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Ya")),
                        const SizedBox(width: 10),
                        Flexible(
                            child: Radio<bool>(
                          value: false,
                          groupValue: _isHaveSkck,
                          onChanged: (value) {
                            setState(() {
                              _isHaveSkck = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Tidak")),
                      ],
                    )
                  ],
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
                    const Text("Bersedia magang"),
                    Row(
                      children: [
                        Flexible(
                            child: Radio<bool>(
                          value: true,
                          groupValue: _isReadyIntern,
                          onChanged: (value) {
                            setState(() {
                              _isReadyIntern = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Ya")),
                        const SizedBox(width: 10),
                        Flexible(
                            child: Radio<bool>(
                          value: false,
                          groupValue: _isReadyIntern,
                          onChanged: (value) {
                            setState(() {
                              _isReadyIntern = value!;
                            });
                          },
                        )),
                        const Flexible(child: Text("Tidak")),
                      ],
                    )
                  ],
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
                    const Text("Platform yang digunakan"),
                    const SizedBox(height: 10),
                    StyledMultiSelectChip(
                      items: _platforms,
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          _selectedPlatforms =
                              List<String>.from(allSelectedItems);
                        });
                      },
                    ),
                    if (_platformErrorMessage != null)
                      ShowValidationMessage(message: _platformErrorMessage!)
                  ],
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
                    const Text("Memiliki Surat Izin Mengemudi?"),
                    const SizedBox(height: 10),
                    StyledMultiSelectChip(
                      items: _driveLicenses,
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          _selectedDriveLicenses =
                              List<String>.from(allSelectedItems);
                        });
                      },
                    )
                  ],
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
                    Row(
                      children: [
                        const Text("Bidang yang kamu minati "),
                        Text("(maksimal $_industryMax)",
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    StyledMultiSelectChip(
                      maxSelectable: _industryMax,
                      items: _talentPoolProvider.industries
                          .map((industry) =>
                              MultiSelectCard(value: industry, label: industry))
                          .toList(),
                      onChange: (allSelectedItems, selectedItem) {
                        setState(() {
                          _selectedIndustries =
                              List<String>.from(allSelectedItems);
                        });
                      },
                    ),
                    if (_industryErrorMessage != null)
                      ShowValidationMessage(message: _industryErrorMessage!)
                  ],
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
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.secondary, width: 1)),
                      child: MultiSelectDialogField<String>(
                          title: const Text("Pilih profesi diinginkan"),
                          buttonText: const Text("Pilih profesi diinginkan"),
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return 'Harap pilih minimal 1';
                            } else if (values.length > _professionMax) {
                              return 'Maksimal 3 pilihan';
                            }
                            return null;
                          },
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          selectedColor: AppColor.secondary,
                          dialogWidth: 600,
                          searchable: true,
                          chipDisplay: MultiSelectChipDisplay(
                              textStyle: const TextStyle(color: Colors.white),
                              icon: const Icon(
                                FontAwesomeIcons.xmark,
                                color: Colors.white,
                              ),
                              onTap: (value) {
                                setState(() {
                                  _selectedProfessions.remove(value);
                                });
                              },
                              chipColor: AppColor.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          items: _talentPoolProvider.professionData
                              .map((profession) => MultiSelectItem<String>(
                                  profession.name, profession.id))
                              .toList(),
                          onConfirm: (values) {
                            setState(() {
                              _selectedProfessions = values;
                            });
                          }),
                    )
                    // SimpleMultipleSelect(
                    //   cancelButtonLabel: "CANCEL",
                    //   okButtonLabel: "OK",
                    //   dataSources: _talentPoolProvider.professionData
                    //       .map((profession) => {
                    //             "display": profession.id,
                    //             "value": profession.name
                    //           })
                    //       .toList(),
                    //   onSaved: (value) {
                    //     if (value == null) return;
                    //     setState(() {
                    //       _selectedProfessions = List<String>.from(value);
                    //     });
                    //   },
                    //   title: Row(
                    //     children: [
                    //       const Text("Pilih profesi diinginkan "),
                    //       Text(
                    //         "maksimal $_professionMax",
                    //         style:
                    //             TextStyle(color: Colors.grey.withOpacity(.7)),
                    //       )
                    //     ],
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.length == 0) {
                    //       return 'Harap pilih minimal 1';
                    //     } else if (value.length > 3) {
                    //       return 'Maksimal 3 pilihan';
                    //     }
                    //     return null;
                    //   },
                    //   hintText: "pilih profesi",
                    // )
                  ],
                ))
              ],
            ),
            const SizedBox(height: _space),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Surat pengalaman"),
                    if (_imagesErrorMessage != null)
                      ShowValidationMessage(message: _imagesErrorMessage!),
                    SmallTextIconButton.square(
                      text: "Upload surat pengalaman",
                      onPressed: () async {
                        var picked = await FilePicker.platform
                            .pickFiles(allowMultiple: true);

                        if (picked != null) {
                          setState(() {
                            _uploadedImages = picked.files;
                          });
                        }
                      },
                      icon: FontAwesomeIcons.paperclip,
                    ),
                    if (_uploadedImages != null) _previewUploadedImage()
                  ],
                )),
              ],
            ),
            const SizedBox(height: _space),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColor.secondary,
              title: const Text("Mempunyai kesibukkan kerja?",
                  style: TextStyle(fontSize: 14)),
              value: _isStillWorking,
              onChanged: (value) => setState(() => _isStillWorking = value!),
            ),
            if (_isStillWorking) _showStillWorkingForm(),
            const SizedBox(height: _space),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColor.secondary,
              title: const Text(
                "Mempunyai kesibukkan studi?",
                style: TextStyle(fontSize: 14),
              ),
              value: _isStillStudying,
              onChanged: (value) => setState(() => _isStillStudying = value!),
            ),
            if (_isStillStudying) _showStillStudyingForm(),
            const SizedBox(height: _space),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColor.secondary),
                  onPressed: () {
                    setState(() {
                      _validateIndustry();
                      _validatePlatform();
                      _validateImages();
                    });
                    if (widget.formKey.currentState!.validate() &&
                        _platformErrorMessage == null &&
                        _industryErrorMessage == null &&
                        _imagesErrorMessage == null) {
                      PostActivityUseCase.exec(ActivityRequest(
                          type: ActivityTypeUtil.webSaveJobCriteria,
                          extra: ActivityExtraRequest(
                              state: "tap",
                              widget: "button",
                              screen: "talent pool")));

                      _saveJobCriteria();
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

  Future<Widget> _showTalentPoolTerms() async {
    bool isSignatureLoading = false;

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Syarat & Ketentuan"),
              content: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TalentPoolTerms(),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                child: Text(
                                  "Tanda Tangan",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: _space),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0))),
                                child: Signature(
                                  controller: _signatureController,
                                  width: double.infinity,
                                  height: 300,
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.undo),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _signatureController.undo();
                                });
                                context
                                    .read<TalentPoolProvider>()
                                    .isSignatureEmpty(_signatureController);
                              },
                            ),
                            //CLEAR CANVAS
                            IconButton(
                              icon: const Icon(Icons.clear),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _signatureController.clear();
                                  PostActivityUseCase.exec(ActivityRequest(
                                      type: ActivityTypeUtil.webClearSignature,
                                      extra: ActivityExtraRequest(
                                          state: "tap",
                                          widget: "icon",
                                          screen: "talent pool")));
                                });
                                context
                                    .read<TalentPoolProvider>()
                                    .isSignatureEmpty(_signatureController);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: _space),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: SmallLoadingButton(
                          isLoading: isSignatureLoading,
                          onPressed: context.watch<TalentPoolProvider>().isAgree
                              ? () async {
                                  if (isSignatureLoading) return;
                                  setState(() => isSignatureLoading = true);

                                  var response = await _saveContract();

                                  PostActivityUseCase.exec(ActivityRequest(
                                      type: ActivityTypeUtil.webAssignContract,
                                      extra: ActivityExtraRequest(
                                          state: "tap",
                                          widget: "button",
                                          screen: "talent pool")));

                                  if (!mounted) return;
                                  Navigator.of(context).pop();

                                  if (response.error == false) {
                                    _talentPoolProvider.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  }
                                }
                              : null,
                          loadingText: "Sedang Memproses",
                          text: context.watch<TalentPoolProvider>().isAgree
                              ? "Saya telah Tanda tangan & Setuju"
                              : "Silahkan melakukan Tanda tangan",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Widget _showStillWorkingForm() {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mulai Kerja"),
            SimpleOutlinedPickerInput(
                controller: widget.startWorkingHourController,
                hintText: "pilih jam mulai kerja",
                onTap: () {
                  setState(() {
                    TimePickerUtil.picker(context).then(
                        (selectedStartWorkingHour) =>
                            widget.startWorkingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                  });
                })
          ],
        )),
        const SizedBox(width: _space),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selesai Kerja"),
            SimpleOutlinedPickerInput(
                controller: widget.endWorkingHourController,
                hintText: "pilih jam selesai kerja",
                onTap: () {
                  setState(() {
                    TimePickerUtil.picker(context).then(
                        (selectedStartWorkingHour) =>
                            widget.endWorkingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                  });
                })
          ],
        )),
      ],
    );
  }

  Widget _showStillStudyingForm() {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mulai Studi"),
            SimpleOutlinedPickerInput(
                controller: widget.startStudyingHourController,
                hintText: "pilih jam mulai studi",
                onTap: () {
                  setState(() {
                    TimePickerUtil.picker(context).then(
                        (selectedStartWorkingHour) =>
                            widget.startStudyingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                  });
                })
          ],
        )),
        const SizedBox(width: _space),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selesai Studi"),
            SimpleOutlinedPickerInput(
                controller: widget.endStudyingHourController,
                hintText: "pilih jam selesai kerja",
                onTap: () {
                  setState(() {
                    TimePickerUtil.picker(context).then(
                        (selectedStartWorkingHour) =>
                            widget.endStudyingHourController.text =
                                DateFormat("HH:mm").format(
                                    TimePickerUtil.convertTimeOfDayToDateTime(
                                        selectedStartWorkingHour!)));
                  });
                })
          ],
        )),
      ],
    );
  }

  Widget _previewUploadedImage() {
    List<Widget> uploadedImageWidgets = [];

    for (var uploadedImage in _uploadedImages!) {
      uploadedImageWidgets.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Image.memory(
          uploadedImage.bytes!,
          width: 180,
          height: 280,
        ),
      ));
    }
    return Wrap(
      children: [...uploadedImageWidgets],
    );
  }

  Future<TalentPoolContractResponse> _saveContract() async {
    try {
      _uploadedSignaturePhoto = await _signatureController.toPngBytes();

      CreateTalentPoolContractRequest contractRequest =
          CreateTalentPoolContractRequest(
              type: "elite",
              documentUrl: null,
              signatureUrl: _uploadedSignaturePhoto);

      TalentPoolContractResponse response =
          await _talentPoolProvider.saveContract(contractRequest);

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _saveJobCriteria() async {
    String? userId = await LocalStorageUtil.readId();

    try {
      if (_uploadedImages != null) {
        for (var uploadedImage in _uploadedImages!) {
          _base64UploadedImages.add(base64Encode(uploadedImage.bytes!));
        }
      }

      CreateTalentPoolJobCriteriaRequest request =
          CreateTalentPoolJobCriteriaRequest(
              userId: userId!,
              // userId: "62ac3385e1457b37707923a9",
              phoneNumber: widget.phoneNumberController.text,
              platforms: _selectedPlatforms,
              industries: _selectedIndustries,
              currentWorkingHours:
                  "${widget.startWorkingHourController.text}-${widget.endWorkingHourController.text}",
              currentStudyHours:
                  "${widget.startStudyingHourController.text}-${widget.endStudyingHourController.text}",
              typeJob: _typeJob,
              isReadyIntern: _isReadyIntern,
              locationType: _locationType,
              isHaveVehicle: _isHaveVehicle,
              driverLicenses: _selectedDriveLicenses,
              isVaccinated: _isVaccinated,
              isHaveSkck: _isHaveSkck,
              roles: _selectedProfessions,
              experienceAttachments: _base64UploadedImages);

      TalentPoolJobCriteriaResponse response =
          await _talentPoolProvider.saveJobCriteria(request);

      if (response.id.isNotEmpty) {
        _showTalentPoolTerms();
      }
    } on InternalServerErrorException catch (error) {
      if (error.toString().contains("User Job Criteria already created")) {
        _showTalentPoolTerms();
      }
    } catch (_) {
      rethrow;
    }
  }

  void _validatePlatform() {
    if (_selectedPlatforms.isEmpty) {
      _platformErrorMessage = "Mohon pilih platform yang digunakan";
    } else {
      _platformErrorMessage = null;
    }
  }

  void _validateIndustry() {
    if (_selectedIndustries.isEmpty) {
      _industryErrorMessage = "Mohon pilih bidang yang diminati";
    } else if (_selectedIndustries.length > 3) {
      _industryErrorMessage = "Maksimal 3 pilihan";
    } else {
      _industryErrorMessage = null;
    }
  }

  void _validateImages() {
    if (_uploadedImages != null) {
      if (_uploadedImages!.length > 5) {
        _imagesErrorMessage = "Maksimal 5 gambar";
      } else {
        _imagesErrorMessage = null;
      }
    }
  }
}
