import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/widgets/show_validation_message.dart';

import '../../../../../../core/widgets/simple_outlined_text_input.dart';
import '../../../../../../core/widgets/small_loading_button.dart';
import '../../../../../../core/widgets/small_outline_button.dart';
import '../../../../landing_page/style/app_color.dart';

class OtpDialog extends StatefulWidget {
  final GlobalKey<FormState> otpFormKey;
  final TextEditingController otpController;
  final Function() onSubmitted, onResendOtp, onClosed;
  final String phoneNumber;
  final String? errorMessage;
  final bool isLoading, canResendOtp;
  final int otpCounter;

  const OtpDialog(
      {required this.otpFormKey,
      required this.otpController,
      required this.onSubmitted,
      required this.onResendOtp,
      required this.onClosed,
      required this.phoneNumber,
      this.errorMessage,
      required this.isLoading,
      required this.canResendOtp,
      required this.otpCounter,
      Key? key})
      : super(key: key);

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(20),
      actionsPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      title: const Text("Isi OTP"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 350,
            child: Text(
                "Silahkan masukkan kode OTP yang telah kami kirimkan ke ${widget.phoneNumber}",
                textAlign: TextAlign.center),
          ),
          // Text("kami kirimkan ke ${widget.phoneNumber}", textAlign: TextAlign.center,),
          Form(
              key: widget.otpFormKey,
              child: Column(
                children: [
                  SimpleOutlinedTextInput(
                    margin: EdgeInsets.zero,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    controller: widget.otpController,
                    hintText: "isi otp anda",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    customValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon kolom ini di isi.";
                      } else if (widget.otpController.text.length < 6) {
                        return "panjang OTP tidak sesuai";
                      }
                      return null;
                    },
                  ),
                  if (widget.errorMessage != null)
                    ShowValidationMessage(
                      message: widget.errorMessage!,
                      fontSize: 16,
                    ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Tidak menerima kode OTP?",
                          ),
                          TextButton(
                              style: widget.canResendOtp
                                  ? null
                                  : ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                              onPressed: () {
                                widget.canResendOtp
                                    ? widget.onResendOtp()
                                    : null;
                              },
                              child: widget.canResendOtp
                                  ? const Text("Kirim ulang OTP",
                                      style:
                                          TextStyle(color: AppColor.secondary))
                                  : Text(
                                      "Kirim ulang OTP dalam ${widget.otpCounter} detik",
                                      style:
                                          const TextStyle(color: Colors.grey)))
                        ],
                      ))
                ],
              ))
        ],
      ),
      actions: ResponsiveWidget.isSmallScreen(context)
          ? [
              SmallLoadingButton(
                buttonSize: const Size.fromHeight(50),
                text: "Verifikasi",
                onPressed: widget.onSubmitted,
                isLoading: widget.isLoading,
              ),
              const SizedBox(height: 20),
              SmallOutlineButton(
                  buttonSize: const Size.fromHeight(50),
                  text: "Tutup",
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  onPressed: widget.onClosed),
            ]
          : [
              SmallOutlineButton(
                  text: "Tutup",
                  primaryColor: AppColor.secondary,
                  borderColor: AppColor.secondary,
                  onPressed: widget.onClosed),
              SmallLoadingButton(
                text: "Verifikasi",
                onPressed: widget.onSubmitted,
                isLoading: widget.isLoading,
              ),
            ],
    );
  }
}
