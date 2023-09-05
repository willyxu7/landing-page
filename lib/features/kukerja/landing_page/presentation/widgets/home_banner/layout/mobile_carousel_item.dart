import 'package:flutter/material.dart';

import '../../../../../../../core/config/responsive.dart';

class MobileCarouselItem extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget topButton;
  final Widget bottomButton;

  const MobileCarouselItem(
      {required this.title,
      required this.description,
      required this.imagePath,
      required this.topButton,
      required this.bottomButton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          ResponsiveWidget.isMediumScreen(context) ? 30 : 34,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat'),
                )),
                const SizedBox(height: 15),
                SizedBox(
                    child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
                // const SizedBox(height: 15),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [topButton, const SizedBox(height: 15), bottomButton],
            ),
          ),
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
