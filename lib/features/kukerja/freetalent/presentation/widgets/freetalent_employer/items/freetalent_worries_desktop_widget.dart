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
                    child: Image.asset('assets/images/campaign-8.png',
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
                    Heading4(text: 'Long Process & Time Consuming in Hiring'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'From job post to hiring using social media or platform needs days often weeks to be done',
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
                    Heading4(text: 'Growth Slowly'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'You figure out something to market fit, you need to execute faster but you have limited resources',
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
                    child: Image.asset('assets/images/campaign-7.png',
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
                    child: Image.asset('assets/images/campaign-6.png',
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
                    Heading4(text: 'Low Hiring Rate and High Turnover'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Because you are small business, your hiring rate are none like the others',
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
                    Heading4(text: 'Limited Access to Talent or Workers'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "In order to growth and scale faster, don't let your time wasted in finding great talent, leave it to us!",
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
                    child: Image.asset('assets/images/campaign-5.png',
                        fit: BoxFit.contain, alignment: Alignment.bottomCenter),
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
