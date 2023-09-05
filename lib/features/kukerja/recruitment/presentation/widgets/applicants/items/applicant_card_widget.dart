import 'package:flutter/material.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/widgets/small_button.dart';
import '../../../../../../../env/kukerja_env.dart';

class ApplicantCardWidget extends StatefulWidget {
  final String id;
  final String profilePhotoPath;
  final String name;
  final String lastJobExperience;
  final double height;
  final double width;
  final double avatarRadius;

  const ApplicantCardWidget({
    required this.id,
    required this.profilePhotoPath,
    required this.name,
    required this.lastJobExperience,
    this.height = 280,
    this.width = 160,
    this.avatarRadius = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<ApplicantCardWidget> createState() => _ApplicantCardWidgetState();
}

class _ApplicantCardWidgetState extends State<ApplicantCardWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: widget.height,
      width: widget.width,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePhotoPath),
            radius: widget.avatarRadius,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            // minFontSize: 16,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.lastJobExperience,
            textAlign: TextAlign.center,
            // minFontSize: 12,
            maxLines: null,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          SmallButton(
            text: 'Lihat Profil',
            onPressed: () {
              PostActivityUseCase.exec(ActivityRequest(
                detail: widget.id,
                  type: ActivityTypeUtil.webSeeProfile,
                extra: ActivityExtraRequest(
                  state: 'tap',
                  widget: 'profile',
                  screen: 'applicant'
                )
              ));
              KukerjaEnv.launchKukerjaAppLink();
            },
            fontSize: 14,
            buttonSize: const Size(130, 50),
          )
        ],
      ),
    );
  }
}
