import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';

import '../../../../../../../core/widgets/heading_3.dart';
import '../../../../../../../core/widgets/heading_4.dart';


class FreetalentWorriesDesktopWidget extends StatelessWidget {
  const FreetalentWorriesDesktopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Column(
        children: [
          const Heading3(
            text: "DON'T LET THIS HAPPENDED TO YOU",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Increase your chances to land your dream job through missions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  width: 419,
                  height: 286,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/campaign-1.png',
                        fit: BoxFit.contain, alignment: Alignment.bottomCenter),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Heading4(text: 'You Are Not The First Choice To Hire'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Low chance  to be hired because your CV lack of experiences',
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Heading4(text: 'Your Skill in CV Is Empty'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Since you are fresh graduate, your skill is limited and need to be proof',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 4,
                child: Container(
                  width: 419,
                  height: 286,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/campaign-2.png',
                        fit: BoxFit.contain, alignment: Alignment.bottomRight),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  width: 419,
                  height: 286,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/campaign-4.png',
                        fit: BoxFit.contain, alignment: Alignment.bottomRight),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Heading4(text: 'Insufficient Fund'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Since you have no income, your chance to upgrade skill still limited',
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Heading4(text: 'Busy Applying Jobs Everywhere'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Maybe right now, you have been applied more than a dozen jobs but no progress',
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 4,
                child: Container(
                  width: 419,
                  height: 286,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/campaign-3.png',
                        fit: BoxFit.contain, alignment: Alignment.bottomRight),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
