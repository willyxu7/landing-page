import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:flutter/material.dart';

import '../../../../style/app_color.dart';

class RecruitmentContainerMobile extends StatelessWidget {
  final Size screenSize;
  final String title;
  final String avatarPath;
  final Function() onPress;
  final String buttonText;

  const RecruitmentContainerMobile(
      {required this.screenSize,
      required this.title,
      required this.avatarPath,
      required this.onPress,
      required this.buttonText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: screenSize.width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: AutoSizeText(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.primary),
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            backgroundColor: Colors.white,
            radius: 60,
          ),
          // Flexible(
          //   child: Text(
          //     content,
          //     style: const TextStyle(fontSize: 14, color: Colors.white),
          //   ),
          // ),
          SmallButton(text: buttonText, onPressed: onPress)
        ],
      ),
    );
  }
}
