import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class JobSeekerProfileScreen extends StatelessWidget {
  static const route = '/profile-picture';
  final String _profileImagePath = QR.params["profileImagePath"].toString();

  JobSeekerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
              utf8.decode(List<int>.from(jsonDecode(_profileImagePath)))),
        ),
      ),
    );
  }
}
