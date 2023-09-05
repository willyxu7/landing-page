import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/recommendations/items/recommendation_card_widget.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/recommendations/items/recommendation_header_mobile_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../data/models/response/recommendation_response.dart';
import '../../../providers/recommendation_provider.dart';

class RecommendationMobileWidget extends StatefulWidget {
  const RecommendationMobileWidget({Key? key}) : super(key: key);

  @override
  State<RecommendationMobileWidget> createState() =>
      _RecommendationMobileWidgetState();
}

class _RecommendationMobileWidgetState
    extends State<RecommendationMobileWidget> {
  List<RecommendationResponse> _recommendationResponses = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _recommendationResponses =
        context.watch<RecommendationProvider>().recommendedJobSeekerResponse;
    super.didChangeDependencies();
  }

  List<Widget> getRecommendedJobSeeker() {
    return _recommendationResponses.map((jobSeeker) {
      return (RecommendationCardWidget(
        id: jobSeeker.profileEmployee!.id,
        profilePhotoPath: jobSeeker.profileEmployee!.imageProfileUrl,
        name: jobSeeker.profileEmployee!.name,
        age: jobSeeker.profileEmployee!.age,
        lastJobExperience: (jobSeeker.profileEmployee!.experiences!.isNotEmpty)
            ? '${jobSeeker.profileEmployee!.experiences![0].position} di ${jobSeeker.profileEmployee!.experiences![0].companyName}'
            : "Belum memiliki pengalaman",
        lastEducation:
            'Pendidikan ${jobSeeker.profileEmployee!.educations![0].level}',
        avatarRadius: SizeConfig.screenWidth * 0.07,
        link: jobSeeker.profileEmployee!.link,
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: const EdgeInsets.only(top: 24, left: 4, right: 4, bottom: 24),
      child: Column(children: [
        RecommendationHeaderMobileWidget(
          countJobSeeker: _recommendationResponses.length,
        ),
        const SizedBox(
          height: 24,
        ),
        Wrap(
            spacing: 8,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [...getRecommendedJobSeeker()])
      ]),
    );
  }
}
