import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/ask_for_workers/items/ask_for_worker_mobile_widget.dart';

import 'items/ask_for_worker_desktop_widget.dart';

class AskForWorkerWidget extends StatefulWidget {
  const AskForWorkerWidget({Key? key}) : super(key: key);

  @override
  State<AskForWorkerWidget> createState() => _AskForWorkerWidgetState();
}

class _AskForWorkerWidgetState extends State<AskForWorkerWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _criteriaController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String selectedGender = '';
  String selectedAge = '';
  String selectedEducationQualification = '';
  String selectedLocation = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? AskForWorkerMobileWidget(
            employerNameController: _employerNameController,
            jobTitleController: _jobTitleController,
            criteriaController: _criteriaController,
            qualificationController: _qualificationController,
            phoneNumberController: _phoneNumberController,
            formKey: _formKey)
        : AskForWorkerDesktopWidget(
            employerNameController: _employerNameController,
            jobTitleController: _jobTitleController,
            criteriaController: _criteriaController,
            qualificationController: _qualificationController,
            phoneNumberController: _phoneNumberController,
            formKey: _formKey,);
  }
}
