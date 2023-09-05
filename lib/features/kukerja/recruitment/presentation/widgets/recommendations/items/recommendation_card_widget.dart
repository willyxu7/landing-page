import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kukerja_web/core/routes/job_seeker_route.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/recommendation_provider.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../../core/widgets/small_button.dart';
import '../../../../../../../env/kukerja_env.dart';
import '../../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../../activity/data/models/requests/activity_request.dart';
import '../../../../../activity/domain/usecases/post_activity_use_case.dart';

class RecommendationCardWidget extends StatefulWidget {
  final String id;
  final String _profilePhotoPath;
  final String name;
  final int? age;
  final String lastJobExperience;
  final String lastEducation;
  final double height;
  final double width;
  final double avatarRadius;
  final String link, buttonText;
  final Function()? onAvaTapped, onProfilePressed;

  RecommendationCardWidget(
      {required this.id,
      required String profilePhotoPath,
      required this.name,
      this.age,
      required this.lastJobExperience,
      required this.lastEducation,
      this.height = 280,
      this.width = 160,
      this.avatarRadius = 0,
      required this.link,
      this.buttonText = "Lihat Profile",
      this.onAvaTapped,
      this.onProfilePressed,
      Key? key})
      : _profilePhotoPath = (profilePhotoPath.isNotEmpty)
            ? profilePhotoPath
            : '/assets/images/asset-22.png',
        super(key: key);

  @override
  _RecommendationCardWidgetState createState() =>
      _RecommendationCardWidgetState();
}

class _RecommendationCardWidgetState extends State<RecommendationCardWidget> {
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
          GestureDetector(
            onTap: () {
              QR.navigator.push(
                  "${JobSeekerRoute.baseRoute}/profile-picture/${utf8.encode(widget._profilePhotoPath)}");
              widget.onAvaTapped != null
                  ? widget.onAvaTapped!()
                  : PostActivityUseCase.exec(ActivityRequest(
                      type: ActivityTypeUtil.webSeeProfile,
                      extra: ActivityExtraRequest(
                          widget: 'circle avatar',
                          screen: 'recommended job seeker',
                          state: 'tap'),
                      detail: widget.id));
            },
            child: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(widget._profilePhotoPath),
              radius: widget.avatarRadius,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${widget.name} / ${widget.age!}',
            textAlign: TextAlign.center,
            // minFontSize: 16,
            style: const TextStyle(fontWeight: FontWeight.bold),
            // maxLines: 2,
            // overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.lastEducation,
            textAlign: TextAlign.center,
            // minFontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
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
            text: widget.buttonText,
            onPressed: () {
              if (widget.onProfilePressed != null) {
                widget.onProfilePressed!();
              } else {
                PostActivityUseCase.exec(ActivityRequest(
                    detail: widget.id,
                    type: ActivityTypeUtil.webSeeProfile,
                    extra: ActivityExtraRequest(
                      state: 'tap',
                      widget: 'profile',
                      screen: 'recommended job seeker',
                      userId: context.read<RecommendationProvider>().employerId,
                    )));
                if (kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
                  KukerjaEnv.launchJobSeekerProfile(widget.link);
                } else if (kIsWeb &&
                    defaultTargetPlatform == TargetPlatform.windows &&
                    defaultTargetPlatform == TargetPlatform.macOS) {
                  KukerjaEnv.launchRecommendedWebLink();
                }
              }
            },
            fontSize: 14,
            buttonSize: const Size(130, 50),
          )
        ],
      ),
    );
  }
}
