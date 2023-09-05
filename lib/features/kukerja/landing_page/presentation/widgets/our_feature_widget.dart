import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/features/kukerja/landing_page/data/datasources/local_data/why_us_local_data.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/our_feature.dart';

class OurFeatureWidget extends StatefulWidget {
  const OurFeatureWidget({Key? key}) : super(key: key);

  @override
  _OurFeatureWidgetState createState() => _OurFeatureWidgetState();
}

class _OurFeatureWidgetState extends State<OurFeatureWidget> {
  final WhyUsLocalData _whyUsLocalData = WhyUsLocalData();

  @override
  Widget build(BuildContext context) {
    List<OurFeature> loadedFeatures = _whyUsLocalData.getOurFeatures();
    var screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: SizeConfig.screenWidth * 0.85,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: (ResponsiveWidget.isSmallScreen(context)
                ? screenSize.width * 1.2
                : ResponsiveWidget.isMediumScreen(context)
                    ? screenSize.width * 0.75
                    : screenSize.width * 0.75) /
            (ResponsiveWidget.isSmallScreen(context) ? 1 : 3) /
            (ResponsiveWidget.isSmallScreen(context)
                ? screenSize.width * 0.9
                : ResponsiveWidget.isMediumScreen(context)
                    ? screenSize.width * 0.38
                    : screenSize.width * 0.18),
        crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 1 : 3,
        children: [
          for (var i in loadedFeatures)
            Container(
              margin: EdgeInsets.all(((screenSize.width * 0.6) /
                      (ResponsiveWidget.isSmallScreen(context) ? 1 : 3)) *
                  0.07),
              padding: EdgeInsets.all(((screenSize.width * 0.6) /
                      (ResponsiveWidget.isSmallScreen(context) ? 1 : 3)) *
                  0.1),
              child: Column(
                crossAxisAlignment: ResponsiveWidget.isSmallScreen(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(i.fileLocation),
                    fit: BoxFit.cover,
                    width: ResponsiveWidget.isSmallScreen(context)
                        ? 40
                        : ResponsiveWidget.isMediumScreen(context)
                            ? 50
                            : ResponsiveWidget.isHDScreen(context)
                                ? 50
                                : 75,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SizedBox(
                    width: (ResponsiveWidget.isSmallScreen(context)
                            ? screenSize.width * 0.85
                            : ResponsiveWidget.isMediumScreen(context)
                                ? screenSize.width * 0.85
                                : screenSize.width * 0.65) /
                        (ResponsiveWidget.isSmallScreen(context) ? 1 : 3),
                    height: ResponsiveWidget.isSmallScreen(context) ? 55 : 45,
                    child: AutoSizeText(i.title.toString(),
                        maxLines: 2,
                        textAlign: ResponsiveWidget.isSmallScreen(context)
                            ? TextAlign.center
                            : TextAlign.left,
                        style: TextStyle(
                            fontSize: ResponsiveWidget.isSmallScreen(context)
                                ? 14
                                : 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                    //  fontSize: 18,
                  ),
                  Flexible(
                    child: AutoSizeText(i.description.toString(),
                        textAlign: ResponsiveWidget.isSmallScreen(context)
                            ? TextAlign.center
                            : TextAlign.left,
                        style: TextStyle(
                            fontSize: ResponsiveWidget.isSmallScreen(context)
                                ? 14
                                : 20,
                            fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
