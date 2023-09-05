import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/responsive.dart';
import '../config/size_config.dart';

class ContactUsFloatingButton extends StatefulWidget {
  final Widget label;
  final Icon icon;
  final Function() onPressed;

  const ContactUsFloatingButton(
      {required this.label,
      this.icon = const Icon(FontAwesomeIcons.whatsapp),
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  State<ContactUsFloatingButton> createState() =>
      _ContactUsFloatingButtonState();
}

class _ContactUsFloatingButtonState extends State<ContactUsFloatingButton> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ResponsiveWidget.isSmallScreen(context)
        ? FloatingActionButton(
            onPressed: () {
              widget.onPressed();
            },
            backgroundColor: Colors.green,
            child: widget.icon,
          )
        : Padding(
            padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.03),
            child: FloatingActionButton.extended(
              onPressed: () {
                widget.onPressed();
              },
              label: widget.label,
              icon: widget.icon,
              backgroundColor: Colors.green,
              elevation: 12,
            ),
          );
  }
}
