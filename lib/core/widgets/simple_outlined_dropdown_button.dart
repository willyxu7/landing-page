import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleOutlinedDropdownButton extends StatefulWidget {
  final List items;
  final Color focusColor;
  final Color borderColor;
  final Icon icon;
  final EdgeInsets margin;
  final String hint;
  final Function onChanged;
  final bool optional;
  final String? initValue;

  const SimpleOutlinedDropdownButton(
      {required this.items,
      this.focusColor = AppColor.secondary,
      this.borderColor = AppColor.secondary,
      this.icon = const Icon(FontAwesomeIcons.angleDown),
      this.margin = const EdgeInsets.only(bottom: 16),
      required this.hint,
      required this.onChanged,
      this.optional = false,
      this.initValue,
      Key? key})
      : super(key: key);

  @override
  State<SimpleOutlinedDropdownButton> createState() =>
      _SimpleOutlinedDropdownButtonState();
}

class _SimpleOutlinedDropdownButtonState
    extends State<SimpleOutlinedDropdownButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: DropdownButtonFormField(
          validator: (value) {
            if (!widget.optional) {
              if (value == null) {
                return 'Mohon kolom ini di isi.';
              }
            }
            return null;
          },
          icon: widget.icon,
          focusColor: Colors.transparent,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusColor: widget.focusColor,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor, width: 2))),
          hint: Text(widget.hint, overflow: TextOverflow.clip,),
          value: widget.initValue,
          items: widget.items.map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (Object? value) {
            widget.onChanged(value!.toString());
          }),
    );
  }
}
