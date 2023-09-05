import 'package:flutter/material.dart';

class ShowValidationMessage extends StatefulWidget {
  final String message;
  final double fontSize;

  const ShowValidationMessage(
      {required this.message, this.fontSize = 12, Key? key})
      : super(key: key);

  @override
  State<ShowValidationMessage> createState() => _ShowValidationMessageState();
}

class _ShowValidationMessageState extends State<ShowValidationMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        widget.message,
        key: widget.key,
        style: TextStyle(color: Colors.red[700], fontSize: widget.fontSize),
      ),
    );
  }
}
