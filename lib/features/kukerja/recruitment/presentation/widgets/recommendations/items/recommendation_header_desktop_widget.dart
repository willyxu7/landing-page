import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/recommendation_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/config/responsive.dart';
import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';

class RecommendationHeaderDesktopWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final int countJobSeeker;

  const RecommendationHeaderDesktopWidget(
      {this.padding, required this.countJobSeeker, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48, bottom: 8),
      padding: padding ?? EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context) ? 16 : 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Rekomendasi 1-$countJobSeeker job seekers',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
            child: TextButton(
                onPressed: () {
                  PostActivityUseCase.exec(ActivityRequest(
                      detail: context.read<RecommendationProvider>().employerId,
                      type: ActivityTypeUtil.webSeeAllRecommendations,
                      extra: ActivityExtraRequest(
                          state: 'tap',
                          screen: 'recommended job seeker',
                          widget: 'see all')));
                  KukerjaEnv.launchKukerjaAppLink();
                },
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );
  }
}
