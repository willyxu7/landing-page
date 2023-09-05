import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/success_story/contract/story.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';

class StoryMobile extends StatefulWidget implements Story {
  @override
  final String imagePath;
  @override
  final String name;
  @override
  final String role;
  @override
  final String description;

  const StoryMobile(
      {required this.imagePath,
      required this.name,
      required this.role,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  State<StoryMobile> createState() => _StoryMobileState();

  @override
  set description(String description) {}

  @override
  set imagePath(String imagePath) {}

  @override
  set name(String name) {}

  @override
  set role(String role) {}
}

class _StoryMobileState extends State<StoryMobile> {
  late Image _avatarImage;

  @override
  void initState() {
    super.initState();

    _avatarImage = Image.asset(widget.imagePath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(_avatarImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.85,
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: _avatarImage.image,
                      radius: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.name,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                          AutoSizeText(
                            widget.role,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                AutoSizeText(
                  widget.description,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
