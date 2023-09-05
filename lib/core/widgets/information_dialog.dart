import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'heading_4.dart';

class InformationDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onPressed;
  final List<Widget>? actions;

  const InformationDialog(
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
            color: Colors.blueAccent),
        child: const Center(
          child: Icon(
            FontAwesomeIcons.circleInfo,
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text("Okay"),
                onPressed: () {
                  if (onPressed != null) onPressed!();
                  Navigator.pop(context);
                })
          ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
