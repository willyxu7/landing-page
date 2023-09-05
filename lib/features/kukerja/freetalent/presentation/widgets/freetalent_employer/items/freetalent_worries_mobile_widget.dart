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
            text: "YOU DON'T WANT THIS TO HAPPENED",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Save your time, efforts and emotions with us',
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
                  child: Image.asset('assets/images/campaign-8.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomCenter),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Long Process & Time Consuming in Hiring',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'From job post to hiring using social media or platform needs days often weeks to be done',
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
                  child: Image.asset('assets/images/campaign-7.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Growth Slowly',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'You figure out something to market fit, you need to execute faster but you have limited resources',
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
                  child: Image.asset('assets/images/campaign-6.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Low Hiring Rate and High Turnover',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Because you are small business, your hiring rate are none like the others',
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
                  child: Image.asset('assets/images/campaign-5.png',
                      fit: BoxFit.contain, alignment: Alignment.bottomRight),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Heading4(
                    text: 'Limited Access to Talent or Workers',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "In order to growth and scale faster, don't let your time wasted in finding great talent, leave it to us!",
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
