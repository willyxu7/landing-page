import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/frequently_asked_question/frequently_asked_question.dart';

class FrequentlyAskedQuestionScreen extends StatelessWidget {
  static const String route = '/frequently-asked-questions';

  const FrequentlyAskedQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavBarDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FrequentlyAskedQuestion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
