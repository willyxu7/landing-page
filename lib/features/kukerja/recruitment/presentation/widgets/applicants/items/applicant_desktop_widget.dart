import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/applicants/items/applicant_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../data/models/response/applicant_response.dart';
import '../../../providers/applicant_provider.dart';
import 'applicant_header_desktop_widget.dart';

class ApplicantDesktopWidget extends StatefulWidget {
  const ApplicantDesktopWidget({Key? key}) : super(key: key);

  @override
  State<ApplicantDesktopWidget> createState() => _ApplicantDesktopWidgetState();
}

class _ApplicantDesktopWidgetState extends State<ApplicantDesktopWidget> {
  ApplicantResponse applicantResponse = ApplicantResponse();

  Widget getApplicantWidget() {
    List<Widget> applicantWidgets = [];

    for (var employee in applicantResponse.employees) {
      applicantWidgets.add(ApplicantCardWidget(
        id: employee.id,
        profilePhotoPath: employee.imageProfileUrl,
        name: employee.name,
        lastJobExperience: employee.lastExperience,
        width: 200,
        avatarRadius: 40,
      ));
    }

    return Wrap(
        spacing: 8,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: applicantWidgets);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    applicantResponse = context.watch<ApplicantProvider>().applicant;
    return SizedBox(
      width: SizeConfig.screenWidth * 0.65,
      child: Column(
          children: [
            ApplicantHeaderDesktopWidget(
                jobTitle: applicantResponse.jobTitle.toString(),
                employerName: applicantResponse.employerName.toString(),
                applicantsLength: applicantResponse.employees.length.toString(),
                totalApplicant: applicantResponse.totalApplicant.toString()),
            const SizedBox(height: 24,),
            getApplicantWidget()
          ]),
    );
  }
}
