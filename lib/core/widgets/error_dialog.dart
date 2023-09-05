import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class ErrorDialog extends StatefulWidget {
  final Object error;
  final Function onOkPressed;

  ErrorDialog(
      {required this.error,
      required this.onOkPressed,
      Key? key})
      : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          color: Colors.red,
          child: const Text(
            "Error!",
            style: TextStyle(color: Colors.white),
          )),
      content: SizedBox(
        width: 400,
        child: Text(widget.error.toString()),
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(primary: AppColor.secondary),
            onPressed: () {
              widget.onOkPressed(false);
            },
            child: const Text("OK"))
      ],
    );
  }
}
