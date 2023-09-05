import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/widgets/heading_3.dart';

class FreetalentStepMobileWidget extends StatelessWidget {
  const FreetalentStepMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(
          vertical: 40.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Image.asset('assets/images/icon-ok.png', width: 80, fit: BoxFit.contain),
          const SizedBox(height: 12),
          const Text(
            'Regis and verified as Employers',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 38),
          Image.asset('assets/images/icon-scroll.png', width: 80, fit: BoxFit.contain),
          const SizedBox(height: 12),
          const Text(
            'Tell us your requirement and our SQUAD will assist',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 38),
          Image.asset('assets/images/icon-wall.png', width: 80, fit: BoxFit.contain),
          const SizedBox(height: 12),
          const Text(
            'Our Free Talent are ready to help you build',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
