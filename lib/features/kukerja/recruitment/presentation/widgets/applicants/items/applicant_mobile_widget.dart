import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/applicant_provider.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/applicants/items/applicant_header_mobile_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../data/models/response/applicant_response.dart';
import 'applicant_card_widget.dart';

class ApplicantMobileWidget extends StatefulWidget {
  const ApplicantMobileWidget({Key? key}) : super(key: key);

  @override
  _ApplicantMobileWidgetState createState() => _ApplicantMobileWidgetState();
}

class _ApplicantMobileWidgetState extends State<ApplicantMobileWidget> {
  ApplicantResponse applicantResponse = ApplicantResponse();

  Widget getApplicantWidget() {
    List<Widget> applicantWidgets = [];

    for (var employee in applicantResponse.employees) {
      applicantWidgets.add(ApplicantCardWidget(
        id: employee.id,
        profilePhotoPath: employee.imageProfileUrl,
        name: employee.name,
        lastJobExperience: employee.lastExperience,
        avatarRadius: SizeConfig.screenWidth * 0.07,
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
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 4, right: 4, bottom: 24),
      child: Column(
        children: [
          ApplicantHeaderMobileWidget(
              jobTitle: applicantResponse.jobTitle.toString(),
              employerName: applicantResponse.employerName.toString(),
              applicantsLength: applicantResponse.employees.length.toString(),
              totalApplicant: applicantResponse.totalApplicant.toString()),
          getApplicantWidget()
        ],
      ),
    );
  }
}
