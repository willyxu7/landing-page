import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 150,
        child: LinearProgressIndicator(
          color: AppColor.primary,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
