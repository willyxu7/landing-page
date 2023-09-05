import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/heading_3.dart';

import '../../../../../../../core/config/size_config.dart';

class FreetalentStepDesktopWidget extends StatelessWidget {
  const FreetalentStepDesktopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        width: SizeConfig.screenWidth * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
        child: Column(
          children: [
            const Heading3(
              text: 'HOW IT WORKS?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '3 Simple steps to get fresh talent and help you build',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 60),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Image.asset('assets/images/icon-ok.png', width: 80, fit: BoxFit.contain),
                    const SizedBox(height: 28),
                    const Text(
                      'Regis and verified as Employers',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/images/icon-scroll.png', width: 80, fit: BoxFit.contain),
                      const SizedBox(height: 28),
                      const Text(
                        'Tell us your requirement and our SQUAD will assist',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Image.asset('assets/images/icon-wall.png', width: 80, fit: BoxFit.contain),
                    const SizedBox(height: 28),
                    const Text(
                      'Our Free Talent are ready to help you build',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                )),
              ],
            )
          ],
        ));
  }
}
