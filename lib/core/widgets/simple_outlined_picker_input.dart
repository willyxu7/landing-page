import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleOutlinedPickerInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final Color focusColor;
  final bool optional, readOnly;
  final Function() onTap;
  final EdgeInsets margin;

  const SimpleOutlinedPickerInput({
    required this.controller,
    required this.hintText,
    this.borderColor = AppColor.secondary,
    this.focusColor = AppColor.secondary,
    this.optional = false,
    this.readOnly = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  _SimpleOutlinedPickerInputState createState() => _SimpleOutlinedPickerInputState();
}

class _SimpleOutlinedPickerInputState extends State<SimpleOutlinedPickerInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: TextFormField(
        validator: (value) {
          if (!widget.optional) {
            if (value == null || value.isEmpty) {
              return 'Mohon kolom ini di isi.';
            }
          }
          return null;
        },
        readOnly: widget.readOnly,
        controller: widget.controller,
        onTap: widget.onTap,
        decoration: InputDecoration(
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
}
