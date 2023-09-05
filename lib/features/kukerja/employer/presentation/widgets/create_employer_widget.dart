import 'dart:convert';
import 'dart:typed_data';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/data/models/responses/city_response.dart';
import 'package:kukerja_web/core/domain/entities/user_type.dart';
import 'package:kukerja_web/core/utils/date_picker_util.dart';
import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/small_loading_button.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/requests/create_employer_request.dart';
import 'package:kukerja_web/features/kukerja/employer/data/models/responses/CreateEmployerResponse.dart';
import 'package:kukerja_web/features/kukerja/employer/presentation/providers/employer_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/responsive.dart';
import '../../../../../core/config/size_config.dart';
import '../../../../../core/utils/company_information_util.dart';
import '../../../../../core/utils/form_util.dart';
import '../../../../../core/widgets/heading_2.dart';
import '../../../../../core/widgets/heading_3.dart';
import '../../../../../core/widgets/simple_outlined_dropdown_search.dart';
import '../../../../../core/widgets/simple_outlined_picker_input.dart';
import '../../../../../core/widgets/simple_outlined_text_area.dart';
import '../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../core/widgets/small_text_icon_button.dart';
import '../../../landing_page/style/app_color.dart';
import 'dart:html' as html;

class CreateEmployerWidget extends StatefulWidget {
  const CreateEmployerWidget({Key? key}) : super(key: key);

  @override
  State<CreateEmployerWidget> createState() => _CreateEmployerWidgetState();
}

class _CreateEmployerWidgetState extends State<CreateEmployerWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late EmployerProvider _employerProvider;
  final TextEditingController _establishedDateController =
          TextEditingController(),
      _name = TextEditingController(),
      _email = TextEditingController(),
      _address = TextEditingController(),
      _shortInformation = TextEditingController();

  final List<String> _positions = ["Pemilik", "Pengelola", "HRD"];

  bool _isOnConfirm = false;

  String _industry = "", _position = "Pemilik";
  String? _outsidePictureErrorMessage, _insidePictureErrorMessage;
  CityResponse? _city;
  DateTime? _establishedDate;
  Uint8List? _outsidePicture;
  List<PlatformFile>? _uploadedInsidePictures;
  final List<String> _insidePictures = [];

  @override
  Widget build(BuildContext context) {
    _employerProvider = context.watch<EmployerProvider>();
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
                                    Heading3(text: "Informasi Penyedia Kerja")),
                            const SizedBox(height: 40),
                            const Text("Nama Bisnis Anda"),
                            SimpleOutlinedTextInput(
                                controller: _name, hintText: "nama bisnis"),
                            const Text("Email"),
                            SimpleOutlinedTextInput(
                                controller: _email,
                                customValidator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mohon kolom ini di isi.';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Email tidak valid';
                                  } else {
                                    return null;
                                  }
                                },
                                hintText: 'alamat email anda'),
                            const Text('Industri'),
                            SimpleOutlinedDropdownSearch(
                              items: _employerProvider.industries,
                              hintText: "pilih industri",
                              selectedItem: _industry,
                              onChanged: (industry) {
                                _industry = industry;
                              },
                              dropdownBuilder: (context, _) {
                                return _industry.isNotEmpty
                                    ? Text(_industry)
                                    : const Text("pilih profesi",
                                        style: TextStyle(color: Colors.grey));
                              },
                            ),
                            const Text("Kapan didirikan?"),
                            SimpleOutlinedPickerInput(
                                readOnly: true,
                                controller: _establishedDateController,
                                hintText: "pilih tanggal didirikan",
                                onTap: () async {
                                  _establishedDate =
                                      await DatePickerUtil.datePicker(context);

                                  if (_establishedDate != null) {
                                    setState(() {
                                      _establishedDateController.text =
                                          DateFormat.yMMMMd('idr')
                                              .format(_establishedDate!);
                                    });
                                  }
                                }),
                            const Text("Selaku"),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ChipsChoice.single(
                                value: _position,
                                onChanged: (String val) =>
                                    setState(() => _position = val),
                                choiceItems: C2Choice.listFrom<String, String>(
                                    source: _positions,
                                    value: (index, value) => value,
                                    label: (index, value) => value),
                                choiceStyle: const C2ChoiceStyle(
                                  color: AppColor.secondary,
                                ),
                              ),
                            ),
                            const Text("Alamat Bisnis"),
                            SimpleOutlinedTextArea(
                                controller: _address,
                                hintText: "alamat bisnis anda"),
                            const Text("Info Singkat Bisnis"),
                            SimpleOutlinedTextArea(
                                controller: _shortInformation,
                                hintText: "info singkat bisnis anda"),
                            const Text('Dimana Lokasi Bisnis Anda'),
                            SimpleOutlinedDropdownSearch<CityResponse>(
                              items: _employerProvider.cities,
                              hintText: "pilih lokasi",
                              selectedItem: _city,
                              itemAsString: (city) => city.name,
                              onChanged: (city) {
                                _city = city;
                              },
                              dropdownBuilder: (context, _) {
                                return _city != null
                                    ? Text(_city!.name)
                                    : const Text("pilih kota",
                                        style: TextStyle(color: Colors.grey));
                              },
                            ),
                            const Text("Foto Lokasi Tampak Luar"),
                            const Text(
                              "Foto akan ditampilkan setiap lowongan kerja",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            if (_outsidePicture != null)
                              Image.memory(
                                _outsidePicture!,
                                width: double.infinity,
                                height: 200,
                              ),
                            if (_outsidePicture == null)
                              SmallTextIconButton.square(
                                text: "Upload Foto",
                                onPressed: () async {
                                  var picked = await FilePicker.platform
                                      .pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: [
                                        'jpg',
                                        'jpeg',
                                        'png'
                                      ]);

                                  if (picked != null) {
                                    setState(() {
                                      _outsidePicture =
                                          picked.files.first.bytes!;
                                    });
                                  }
                                },
                                icon: FontAwesomeIcons.cameraRetro,
                              ),
                            if (_outsidePictureErrorMessage != null)
                              ShowValidationMessage(
                                  message: _outsidePictureErrorMessage!),
                            const SizedBox(height: 20),
                            const Text("Foto Lokasi Tampak Dalam"),
                            const Text(
                              "Foto akan ditampilkan setiap lowongan kerja",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            if (_uploadedInsidePictures != null)
                              _previewUploadedImage(),
                            SmallTextIconButton.square(
                              text: "Upload Foto",
                              onPressed: () async {
                                var picked = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: true,
                                        type: FileType.custom,
                                        allowedExtensions: [
                                      'jpg',
                                      'jpeg',
                                      'png'
                                    ]);

                                if (picked != null) {
                                  setState(() {
                                    _uploadedInsidePictures = picked.files;
                                  });
                                }
                              },
                              icon: FontAwesomeIcons.cameraRetro,
                            ),
                            if (_insidePictureErrorMessage != null)
                              ShowValidationMessage(
                                  message: _insidePictureErrorMessage!),
                            const SizedBox(height: 20),
                            SmallLoadingButton(
                              text: "Konfirmasi",
                              isLoading: _isOnConfirm,
                              buttonSize: const Size.fromHeight(50),
                              onPressed: () {
                                setState(() {
                                  _validateOutsidePicture();
                                  _validateInsidePicture();
                                });
                                if (_formKey.currentState!.validate() &&
                                    _outsidePicture != null &&
                                    _uploadedInsidePictures != null) {
                                  if (_isOnConfirm) return;

                                  setState(() => _isOnConfirm = true);

                                  _saveEmployer();
                                } else {
                                  FormUtil.showToast(context);
                                }
                              },
                            )
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

  Future<void> _saveEmployer() async {
    try {
      if (_uploadedInsidePictures != null) {
        for (var uploadedInsidePicture in _uploadedInsidePictures!) {
          _insidePictures.add(base64Encode(uploadedInsidePicture.bytes!));
        }
      }

      String? phoneNumber = await LocalStorageUtil.readPhoneNumber();

      CreateEmployerRequest createEmployerRequest = CreateEmployerRequest(
          name: _name.text,
          email: _email.text,
          industry: _industry,
          established: _establishedDate!,
          position: _position,
          address: _address.text,
          shortInformation: _shortInformation.text,
          city: _city!.name,
          phoneNumber: phoneNumber!,
          type: UserType.employer,
          businessImages: _insidePictures,
          outdoorImageUrl: _outsidePicture!);

      CreateEmployerResponse createEmployerResponse =
          await _employerProvider.createEmployer(createEmployerRequest);

      String? isFromSultanRecruitment =
          await LocalStorageUtil.readFromSultanRecruitment();

      if (createEmployerResponse.id.isNotEmpty &&
          isFromSultanRecruitment != null) {
        await LocalStorageUtil.deleteFromSultanRecruitment();
        html.window.location.replace("/sultan-recruitments");
      } else {
        html.window.location.replace("/");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _previewUploadedImage() {
    List<Widget> uploadedImageWidgets = [];

    for (var uploadedImage in _uploadedInsidePictures!) {
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

  void _validateOutsidePicture() {
    if (_outsidePicture == null) {
      _outsidePictureErrorMessage = "Mohon kolom ini di isi.";
    } else if (!FormUtil.isImageLessThanOneMb(_outsidePicture!.lengthInBytes)) {
      _outsidePictureErrorMessage = "Foto tidak boleh lebih dari 1Mb.";
    } else {
      _outsidePictureErrorMessage = "";
    }
  }

  void _validateInsidePicture() {
    if (_uploadedInsidePictures == null) {
      _insidePictureErrorMessage = "Mohon kolom ini di isi.";
    } else if (_uploadedInsidePictures != null) {
      if (_uploadedInsidePictures!.length > 5) {
        _insidePictureErrorMessage = "Maksimal 5 gambar";
      }
    } else {
      _insidePictureErrorMessage = "";
    }
  }
}
