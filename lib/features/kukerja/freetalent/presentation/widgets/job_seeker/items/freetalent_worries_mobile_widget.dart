import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';
import '../../../../../../../core/widgets/heading_3.dart';
import '../../../../../../../core/widgets/heading_4.dart';


class FreetalentWorriesMobileWidget extends StatelessWidget {
  const FreetalentWorriesMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 319,
                height: 186,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/campaign-1.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomCenter),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'You Are Not The First Choice To Hire',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Low chance  to be hired because your CV lack of experiences',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 319,
                height: 186,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/campaign-2.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Your Skill in CV Is Empty',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Since you are fresh graduate, your skill is limited and need to be proof',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 319,
                height: 186,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/campaign-4.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Insufficient Fund',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Since you have no income, your chance to upgrade skill still limited',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 319,
                height: 186,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/campaign-3.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Busy Applying Jobs Everywhere',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Maybe right now, you have been applied more than a dozen jobs but no progress',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
