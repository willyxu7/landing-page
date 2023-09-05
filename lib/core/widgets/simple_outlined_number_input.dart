import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleOutlinedNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final Color focusColor;
  final bool optional;
  final EdgeInsets margin;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final bool readOnly;

  String? Function(String?)? customValidator;

  SimpleOutlinedNumberInput(
      {required this.controller,
      required this.hintText,
      this.borderColor = AppColor.secondary,
      this.focusColor = AppColor.secondary,
      this.optional = false,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.keyboardType = TextInputType.text,
      this.inputFormatters = const [],
      this.maxLength,
      this.readOnly = false,
      this.customValidator,
      Key? key})
      : super(key: key);

  @override
  State<SimpleOutlinedNumberInput> createState() =>
      _SimpleOutlinedNumberInputState();
}

class _SimpleOutlinedNumberInputState extends State<SimpleOutlinedNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: TextFormField(
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        validator:
            widget.customValidator ?? (value) => _defaultValidator(value),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ...widget.inputFormatters
        ],
        decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            border: const OutlineInputBorder(),
            focusColor: widget.focusColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 2)),
            fillColor: Colors.white),
        cursorColor: AppColor.secondary,
      ),
    );
  }

  String? _defaultValidator(String? value) {
    String? message;

    if (!widget.optional) {
      if (value == null || value.isEmpty) {
        message = 'Mohon kolom ini di isi.';
      }
    }

    return message;
  }
}
