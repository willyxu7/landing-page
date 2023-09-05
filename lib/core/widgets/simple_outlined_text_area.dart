import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleOutlinedTextArea extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final Color focusColor;
  final bool optional;
  final EdgeInsets margin;
  final int? maxLength;

  const SimpleOutlinedTextArea(
      {required this.controller,
      required this.hintText,
      this.borderColor = AppColor.secondary,
      this.focusColor = AppColor.secondary,
      this.optional = false,
      this.maxLength,
      this.margin = const EdgeInsets.only(bottom: 16),
      Key? key})
      : super(key: key);

  @override
  _SimpleOutlinedTextAreaState createState() => _SimpleOutlinedTextAreaState();
}

class _SimpleOutlinedTextAreaState extends State<SimpleOutlinedTextArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: TextFormField(
        maxLength: widget.maxLength,
        validator: (value) {
          if (!widget.optional) {
            if (value == null || value.isEmpty) {
              return 'Mohon kolom ini di isi.';
            }
          }
          return null;
        },
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 2))),
        cursorColor: AppColor.secondary,
      ),
    );
  }
}
