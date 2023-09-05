import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/recommendation_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/recommendation_provider.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/recommendations/items/recommendation_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../recommendations/items/recommendation_header_desktop_widget.dart';

class RecommendationDesktopWidget extends StatefulWidget {
  const RecommendationDesktopWidget({Key? key}) : super(key: key);

  @override
  State<RecommendationDesktopWidget> createState() =>
      _RecommendationDesktopWidgetState();
}

class _RecommendationDesktopWidgetState
    extends State<RecommendationDesktopWidget> {
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
        width: 200,
        avatarRadius: 40,
        link: jobSeeker.profileEmployee!.link,

      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: SizeConfig.screenWidth * 0.65,
      child: Column(children: [
        RecommendationHeaderDesktopWidget(
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
