import 'package:carousel_slider/carousel_slider.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/large_button.dart';
import 'package:kukerja_web/core/widgets/large_outline_button.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:flutter/material.dart';

import '../../../../../../env/kukerja_env.dart';
import 'layout/desktop_carousel_item.dart';

class HomeBannerDesktop extends StatefulWidget {
  const HomeBannerDesktop({Key? key}) : super(key: key);

  @override
  _HomeBannerDesktopState createState() => _HomeBannerDesktopState();
}

class _HomeBannerDesktopState extends State<HomeBannerDesktop> {
  final List<DesktopCarouselItem> _mainCarouselItems = [
    DesktopCarouselItem(
        title: 'Cari Kerja, Cari Karyawan Semudah Klik!',
        description:
            'Sebuah peluang yang selalu ada dalam genggaman. Bergabung bersama 2.000+ bisnis dan 20.000+ pekerja lainnya',
        imagePath: 'assets/images/slider-ski-2.png',
        leftButton: LargeButton(
            text: 'Posting Lowongan',
            onPress: () {
              PostActivityUseCase.exec(ActivityRequest(
                  type: ActivityTypeUtil.webPostingJob,
                  extra: ActivityExtraRequest(
                      state: 'tap', widget: 'banner', screen: 'home')));
              KukerjaEnv.launchKukerjaAppLink();
            }),
        rightButton: LargeOutlineButton(
          text: 'Cari Kerja',
          onPress: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webFindingJob,
                extra: ActivityExtraRequest(
                    state: 'tap', widget: 'banner', screen: 'home')));
            KukerjaEnv.launchKukerjaAppLink();
          },
        )),
    // DesktopCarouselItem(
    //     title: 'Cari Kerja, Cari Karyawan Semudah Klik!',
    //     description:
    //         'Misi kami adalah memberdayakan setiap usaha dan SDM di Indonesia untuk tumbuh dan berkembang lebih melalui simplisitas dan konsistensi',
    //     imagePath: '/images/slider-ski-2.png',
    //     leftButton: MediumTextIconButton(
    //         text: 'Posting Lowongan',
    //         onPress: () {},
    //         icon: FontAwesomeIcons.playCircle),
    //     rightButton: MediumTextIconButton(
    //         text: 'Cari Kerja',
    //         onPress: () {},
    //         icon: FontAwesomeIcons.download)),
  ];
  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _mainCarouselItems,
            carouselController: _controller,
            options: CarouselOptions(
                height: SizeConfig.blockSizeVertical * 80,
                enlargeCenterPage: true,
                autoPlay: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                autoPlayCurve: Curves.fastOutSlowIn,
                // enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        _mainCarouselItems.length > 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _mainCarouselItems.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              )
            : Container()
      ],
    );
  }
}
