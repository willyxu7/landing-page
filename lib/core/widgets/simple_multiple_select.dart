import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleMultipleSelect extends StatelessWidget {
  /// Must be map to Map<String, String> with
  /// first key is "display" and second key is "value"
  final List? dataSources;

  final List? initialValues;
  final Function(List?) onSaved;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Widget title;
  final String? Function(dynamic)? validator;
  final String hintText;
  final bool optional;

  const SimpleMultipleSelect(
      {required this.dataSources,
      this.initialValues,
      required this.onSaved,
      required this.okButtonLabel,
      required this.cancelButtonLabel,
      required this.title,
      this.validator,
      this.hintText = "",
      this.optional = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      autovalidate: AutovalidateMode.disabled,
      chipBackGroundColor: AppColor.secondary,
      chipLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: AppColor.secondary,
      checkBoxCheckColor: Colors.white,
      dialogShapeBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      title: title,
      validator: validator ??
          (value) {
            return defaultValidator(value);
          },
      dataSource: dataSources?.cast<dynamic>(),
      textField: 'display',
      valueField: 'value',
      okButtonLabel: okButtonLabel,
      cancelButtonLabel: cancelButtonLabel,
      hintWidget:
          Text(hintText, style: TextStyle(color: Colors.grey.withOpacity(.7))),
      initialValue: initialValues,
      onSaved: (value) {
        onSaved(value);
      },
    );
  }

  String? defaultValidator(String? value) {
    String? message;

    if (optional == false) {
      if (value == null || value.isEmpty) {
        message = 'Harap pilih minimal 1';
      }
      return null;
    }

    return message;
  }
}
