import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/widgets/items/show_candidate.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/widgets/items/sultan_recruitment_sucess.dart';
import 'package:provider/provider.dart';

import '../providers/sultan_recruitment_provider.dart';
import 'items/find_candidate_form_desktop.dart';

class
SultanRecruitmentWidget extends StatefulWidget {
  const SultanRecruitmentWidget({Key? key}) : super(key: key);

  @override
  State<SultanRecruitmentWidget> createState() =>
      _SultanRecruitmentWidgetState();
}

class _SultanRecruitmentWidgetState extends State<SultanRecruitmentWidget> {
  late final SultanRecruitmentProvider _sultanRecruitmentProvider;

  @override
  void initState() {
    super.initState();
    _sultanRecruitmentProvider = context.read<SultanRecruitmentProvider>();

    // _getAccessToken();
  }

  // Future<void> _getAccessToken() async {
  //   User user;
  //
  //   String? accessToken = await _storage.read(key: "tokenIssue");
  //   String? phoneNumber = await _storage.read(key: "phone");
  //
  //   user = await _sultanRecruitmentProvider.fetchProfile();
  //
  //   if (accessToken != null && phoneNumber != null && user.name.isNotEmpty) {
  //     _sultanRecruitmentProvider.pageController.nextPage(
  //         duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 640,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<SultanRecruitmentProvider>().pageController,
        children: const [
          // SingleChildScrollView(child: ShowCandidate()),

          // SingleChildScrollView(child: EmployerInformationFormDesktop()),
          SingleChildScrollView(child: FindCandidateDesktop()),
          SingleChildScrollView(child: ShowCandidate()),
          SingleChildScrollView(child: SultanRecruitmentSuccess()),

          // SingleChildScrollView(
          //   child: ResponsiveWidget.isSmallScreen(context)
          //       ? const ShowCandidateMobile()
          //       : const ShowCandidateDesktop(),
          // ),
        ],
      ),
    );
  }
}
