import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/customer_detail.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:provider/provider.dart';

showBuyerDetailForm(BuildContext context,
    {required int quantity, required Function paymentMethod}) {
  final GlobalKey<FormState> formKey = GlobalKey();
  final nameCtrl = TextEditingController();
  final phonenumberCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String code = '+62';
  String? number;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      content: StatefulBuilder(
        builder: (context, setState) => Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Pemilik Tiket',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   'Saat ini anda menggunakan guest checkout',
                  //   textAlign: TextAlign.start,
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Theme.of(context).hintColor,
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  const Text(
                    'Nama',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nameCtrl,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return value == '' ? 'Mohon isi kolom ini' : null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nama lengkap',
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(51, 216, 216, 216),
                      contentPadding: const EdgeInsets.all(10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Color(0xFF22c0e8), width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value == '') {
                        return 'Mohon kolom ini di isi';
                      } else if (!emailValid) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Alamat email aktif',
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(51, 216, 216, 216),
                      contentPadding: const EdgeInsets.all(10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Color(0xFF22c0e8), width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No Handphone',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phonenumberCtrl,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      return value == ''
                          ? 'Mohon isi kolom ini'
                          : value!.length < 8
                              ? 'Nomor tidak valid'
                              : null;
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.startsWith('0')) {
                          number = code + value.substring(1);
                        } else {
                          number = code + value;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Nomor handphone aktif',
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      errorStyle: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(51, 216, 216, 216),
                      contentPadding: const EdgeInsets.all(10),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).errorColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                            color: Color(0xFF22c0e8), width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final customerDetail = CustomerDetail(
                              name: nameCtrl.text,
                              phonenumber: number.toString(),
                              email: emailCtrl.text,
                              quantity: quantity,
                            );

                            context
                                .read<SnapChargeProvider>()
                                .setCustomerDetails(customerDetail);

                            PostActivityUseCase.exec(ActivityRequest(
                                type: ActivityTypeUtil.webConfirmCustomerData,
                                extra: ActivityExtraRequest(
                                  state: 'tap',
                                )));

                            Navigator.pop(context);
                            paymentMethod();
                          }
                        },
                        child: const Text('Selanjutnya')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
