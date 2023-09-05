import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/talent_pool_job_criteria_desktop_widget.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/talent_pool_success.dart';
import 'package:provider/provider.dart';


class TalentPoolWidget extends StatefulWidget {
  const TalentPoolWidget({Key? key}) : super(key: key);

  @override
  State<TalentPoolWidget> createState() => _TalentPoolWidgetState();
}

class _TalentPoolWidgetState extends State<TalentPoolWidget> {
  late final TalentPoolProvider _talentPoolProvider;
  final GlobalKey<FormState> _jobCriteriaFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _startWorkingHourController =
          TextEditingController(),
      _endWorkingHourController = TextEditingController(),
      _startStudyingHourController = TextEditingController(),
      _endStudyingHourController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _talentPoolProvider = context.read<TalentPoolProvider>();

    // _getAccessToken();
  }

  // Future<void> _getAccessToken() async {
  //   TalentPoolJobCriteriaResponse? jobCriteria;
  //   User user;
  //
  //   String? userId = await _storage.read(key: "id");
  //   String? accessToken = await _storage.read(key: "tokenIssue");
  //   String? phoneNumber = await _storage.read(key: "phone");
  //
  //   if (userId != null) {
  //     jobCriteria = await _talentPoolProvider.fetchJobCriteriaByUserId(userId);
  //   }
  //
  //   user = await _talentPoolProvider.fetchProfile();
  //
  //   if (accessToken != null &&
  //       phoneNumber != null &&
  //       user.name.isNotEmpty) {
  //     _phoneNumberController.text = phoneNumber;
  //     _talentPoolProvider.loggedInUserId = userId;
  //
  //     if (!mounted) return;
  //     _talentPoolProvider.pageController.nextPage(
  //         duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: 640,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<TalentPoolProvider>().pageController,
        children: [
          // const SingleChildScrollView(
          //   child: TalentPoolCVDesktopWidget(),
          // ),
          SingleChildScrollView(
            child: TalentPoolJobCriteriaDesktopWidget(
              formKey: _jobCriteriaFormKey,
              phoneNumberController: _phoneNumberController,
              startWorkingHourController: _startWorkingHourController,
              endWorkingHourController: _endWorkingHourController,
              startStudyingHourController: _startStudyingHourController,
              endStudyingHourController: _endStudyingHourController,
            ),
          ),
          // const SingleChildScrollView(
          //   child: TalentPoolContractDesktopWidget(),
          // ),
          const SingleChildScrollView(
            child: TalentPoolSuccess(),
          )
        ],
      ),
    );
  }
}
