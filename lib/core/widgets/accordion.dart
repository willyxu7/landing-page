import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final List<TextSpan> textSpans;
  final Function() onTap;

  const Accordion(
      {required this.title,
      required this.textSpans,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          title: Text(widget.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat')),
          textColor: Colors.white,
          backgroundColor: AppColor.primary,
          iconColor: Colors.white,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, top: 10, right: 30),
              decoration: const BoxDecoration(color: Colors.white),
              // child: Text(widget.content, style: const TextStyle(fontSize: 14)),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.5,
                        fontFamily: 'Quicksand'),
                    children: widget.textSpans),
              ),
              // color: const Color(0xffe5e9f2),
            )
          ],
        ),
      ),
    );
  }
}
