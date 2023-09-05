import 'package:flutter/material.dart';

import '../../../../../../../core/config/size_config.dart';
import 'job_seeker_info_detail_content_widget.dart';

class JobSeekerCvProfileWidget extends StatelessWidget {
  const JobSeekerCvProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 2,
              child: Image.asset(
                'assets/images/taniar-aulia-rahmadini.jpg',
                width: 150,
              )),
          Flexible(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 28.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Info Detail',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  JobSeekerInfoDetailContentWidget(
                    title: 'Jenis Kelamin',
                    description: 'Wanita',
                  ),
                  JobSeekerInfoDetailContentWidget(
                      title: 'Status',
                      description: 'Menikah'),
                  JobSeekerInfoDetailContentWidget(
                      title: 'Umur',
                      description: '25'),
                  JobSeekerInfoDetailContentWidget(
                      title: 'Agama',
                      description: 'Islam'),
                  JobSeekerInfoDetailContentWidget(
                      title: 'Kota',
                      description:
                      'Kota Pontianak'),
                  JobSeekerInfoDetailContentWidget(
                      title: 'Pekerjaan Sekarang',
                      description: '-')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}