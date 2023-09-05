import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/config/responsive.dart';

class DesktopCarouselItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget leftButton;
  final Widget rightButton;

  const DesktopCarouselItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.leftButton,
    required this.rightButton,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
          vertical: screenSize.height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.02, vertical: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                          // width: (screenSize.width * 3 / 8) -
                          //     (screenSize.width * 0.1),
                          child: AutoSizeText(
                              title,
                              minFontSize: 30,
                              style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveWidget.isHDScreen(context) ? 30 : 48,
                                    fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat'),
                              )),
                      const SizedBox(height: 40),
                      SizedBox(
                          // width: (screenSize.width * 3 / 8) -
                          //     (screenSize.width * 0.1),
                          child: AutoSizeText(
                            description,
                            minFontSize: 28,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.02, vertical: 10.0),
                  child: Row(
                    children: [
                      leftButton,
                      const SizedBox(width: 20),
                      rightButton,
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              // decoration: BoxDecoration(
              //   color: Colors.white
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  // width: (screenSize.width * 5 / 8) * 0.5,
                  // width: 700,
                ),
              ),
              // decoration: BoxDecoration(
              //   border: BoxBorder()
              // ),
            ),
          )
        ],
      ),
    );
  }
}
