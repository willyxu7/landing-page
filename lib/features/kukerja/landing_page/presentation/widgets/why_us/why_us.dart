import 'package:kukerja_web/core/widgets/section_header.dart';
import 'package:flutter/material.dart';

import '../our_feature_widget.dart';

class WhyUs extends StatelessWidget {
  const WhyUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SectionHeader(text: 'Why Us'),
            OurFeatureWidget(),
          ]),
    );
  }
}
