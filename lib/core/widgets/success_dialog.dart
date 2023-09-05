import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';

import 'heading_4.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onPressed;
  final List<Widget>? actions;

  const SuccessDialog(
      {required this.title,
      required this.description,
      this.onPressed,
      this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(top: 24),
      title: Container(
        height: 80,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            color: Colors.green),
        child: const Center(
          child: Icon(
            FontAwesomeIcons.circleCheck,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
      content: SizedBox(
        width: 400,
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Heading4(text: title),
              const SizedBox(height: 10),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      actions: actions ??
          [
            SmallButton(
                buttonSize: const Size.fromHeight(50),
                text: "Okay",
                onPressed: () {
                  if(onPressed != null) onPressed!();
                  Navigator.pop(context);
                })
          ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
