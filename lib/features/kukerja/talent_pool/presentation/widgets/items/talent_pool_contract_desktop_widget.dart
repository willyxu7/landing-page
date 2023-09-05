import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_dropdown_search.dart';
import 'package:kukerja_web/core/widgets/simple_outlined_number_input.dart';
import 'package:kukerja_web/core/widgets/small_text_icon_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_contract_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/requests/create_talent_pool_enrollment_request.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/data/models/responses/talent_pool_contract_response.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/talent_pool_terms.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class TalentPoolContractDesktopWidget extends StatefulWidget {
  const TalentPoolContractDesktopWidget({Key? key}) : super(key: key);

  @override
  State<TalentPoolContractDesktopWidget> createState() =>
      _TalentPoolContractDesktopWidgetState();
}

class _TalentPoolContractDesktopWidgetState
    extends State<TalentPoolContractDesktopWidget> {
  late TalentPoolProvider _talentPoolProvider;

  bool _agree = false;
  final double _space = 10;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FilePicker _filePicker = FilePicker.platform;

  final SignatureController _signatureController = SignatureController();
  final TextEditingController _bankAccountNumber = TextEditingController();

  String _bankAccountName = "";

  String? _idCardErrorMessage, _bankAccountPhotoErrorMessage;

  Uint8List? _uploadedIdCardPhoto,
      _uploadedBankAccountPhoto,
      _uploadedSignaturePhoto;

  @override
  void dispose() {
    super.dispose();

    _bankAccountNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _talentPoolProvider = context.watch<TalentPoolProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Foto KTP"),
                        if (_uploadedIdCardPhoto != null)
                          Image.memory(
                            _uploadedIdCardPhoto!,
                            width: double.infinity,
                            height: 200,
                          ),
                        SizedBox(height: _space),
                        if (_idCardErrorMessage != null)
                          ShowValidationMessage(message: _idCardErrorMessage!),
                        SmallTextIconButton.square(
                            text: "Upload foto KTP",
                            onPressed: () async {
                              var idCard = await _filePicker.pickFiles();
                              if (idCard != null) {
                                setState(() {
                                  _uploadedIdCardPhoto =
                                      idCard.files.first.bytes;
                                });
                              }
                            },
                            icon: FontAwesomeIcons.paperclip)
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nomor Rekening"),
                    SimpleOutlinedNumberInput(
                        controller: _bankAccountNumber,
                        hintText: "masukkan nomor rekening")
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
                    const Text("Nama Bank"),
                    SimpleOutlinedDropdownSearch(
                        items: _talentPoolProvider.banks,
                        onChanged: (value) {
                          setState(() {
                            _bankAccountName = value;
                          });
                        })
                  ],
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Foto Nomor Rekening"),
                        if (_uploadedBankAccountPhoto != null)
                          Image.memory(
                            _uploadedBankAccountPhoto!,
                            width: double.infinity,
                            height: 200,
                          ),
                        SizedBox(height: _space),
                        if (_bankAccountPhotoErrorMessage != null)
                          ShowValidationMessage(
                              message: _bankAccountPhotoErrorMessage!),
                        SmallTextIconButton.square(
                            text: "Upload foto nomor rekening",
                            onPressed: () async {
                              var accountNumberPhoto =
                                  await _filePicker.pickFiles();
                              if (accountNumberPhoto != null) {
                                setState(() {
                                  _uploadedBankAccountPhoto =
                                      accountNumberPhoto.files.first.bytes;
                                });
                              }
                            },
                            icon: FontAwesomeIcons.paperclip)
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColor.secondary),
                  onPressed: () {
                    setState(() {
                      _validateIdCard();
                      _validateBankAccountPhoto();
                    });
                    if (_formKey.currentState!.validate() &&
                        _idCardErrorMessage == null &&
                        _bankAccountPhotoErrorMessage == null) {
                      showTalentPoolTerms();
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

  Future<Widget> showTalentPoolTerms() async {
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
                              const Text("Tanda Tangan"),
                              SizedBox(height: _space),
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
                            //SHOW EXPORTED IMAGE IN NEW ROUTE
                            IconButton(
                              icon: const Icon(Icons.check),
                              color: Colors.blue,
                              onPressed: () {
                                if (_signatureController.isNotEmpty) {
                                  setState(() => _agree = true);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.undo),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _signatureController.undo();
                                  if (_signatureController.isEmpty) {
                                    _agree = false;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.redo),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() => _signatureController.redo());
                              },
                            ),
                            //CLEAR CANVAS
                            IconButton(
                              icon: const Icon(Icons.clear),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  _signatureController.clear();
                                  _agree = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _space),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColor.secondary),
                            onPressed: _agree
                                ? () async {
                                    var response = await _saveContract();
                                    if (!mounted) return;
                                    Navigator.of(context).pop();

                                    if (response.error == false) {
                                      _talentPoolProvider.pageController
                                          .nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeIn);
                                    }
                                  }
                                : null,
                            child: const Text(
                              "Setuju",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<TalentPoolContractResponse> _saveContract() async {
    _uploadedSignaturePhoto = await _signatureController.toPngBytes();

    CreateTalentPoolContractRequest contractRequest =
        CreateTalentPoolContractRequest(
            type: "elite",
            documentUrl: null,
            signatureUrl: _uploadedSignaturePhoto);

    CreateTalentPoolEnrollmentRequest enrollmentRequest =
        CreateTalentPoolEnrollmentRequest(
            idCardImage: _uploadedIdCardPhoto,
            bankAccountImage: _uploadedBankAccountPhoto,
            bankAccountName: _bankAccountName,
            bankAccountNumber: _bankAccountNumber.text);

    TalentPoolContractResponse response =
        await _talentPoolProvider.saveContract(contractRequest);

    return response;
  }

  void _validateIdCard() {
    if (_uploadedIdCardPhoto == null) {
      _idCardErrorMessage = "Mohon upload foto ktp anda";
    } else {
      _idCardErrorMessage = null;
    }
  }

  void _validateBankAccountPhoto() {
    if (_uploadedBankAccountPhoto == null) {
      _bankAccountPhotoErrorMessage = "Mohon upload foto nomor rekening anda";
    } else {
      _bankAccountPhotoErrorMessage = null;
    }
  }
}
