import 'package:kukerja_web/core/widgets/medium_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:flutter/material.dart';

class RecruitmentContainerDesktop extends StatelessWidget {
  final Size screenSize;
  final String title;
  final String avatarPath;
  final Function() onPress;
  final String buttonText;

  const RecruitmentContainerDesktop(
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
      padding: const EdgeInsets.all(20),
      width: screenSize.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary),
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            backgroundColor: Colors.white,
            radius: 100,
          ),
          // Flexible(
          //   child: Text(
          //     content,
          //     style: const TextStyle(fontSize: 14, color: Colors.white),
          //   ),
          // ),
          MediumButton(text: buttonText, onPress: onPress)
        ],
      ),
    );
  }
}
