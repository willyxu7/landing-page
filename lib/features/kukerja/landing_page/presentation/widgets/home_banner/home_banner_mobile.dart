import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/home_banner/layout/mobile_carousel_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../../../env/kukerja_env.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';

class HomeBannerMobile extends StatefulWidget {
  const HomeBannerMobile({Key? key}) : super(key: key);

  @override
  _HomeBannerMobileState createState() => _HomeBannerMobileState();
}

class _HomeBannerMobileState extends State<HomeBannerMobile> {
  final List<MobileCarouselItem> _mainCarouselItems = [
    MobileCarouselItem(
      title: 'Cari Kerja, Cari Karyawan Semudah Klik!',
      description:
          'Sebuah peluang yang selalu ada dalam genggaman. Bergabung bersama 2.000+ bisnis dan 20.000+ pekerja lainnya',
      imagePath: 'assets/images/slider-ski-2.png',
      topButton: SmallButton(
          text: 'Posting Lowongan',
          onPressed: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webPostingJob,
                extra: ActivityExtraRequest(
                    state: 'tap', widget: 'banner', screen: 'home')));
            KukerjaEnv.launchKukerjaAppLink();
          }),
      bottomButton: SmallOutlineButton(
          text: 'Cari Kerja',
          onPressed: () {
            PostActivityUseCase.exec(ActivityRequest(
                type: ActivityTypeUtil.webFindingJob,
                extra: ActivityExtraRequest(
                    state: 'tap', widget: 'banner', screen: 'home')));
            KukerjaEnv.launchKukerjaAppLink();
          }),
    ),
    // MobileCarouselItem(
    //     title: 'Cari Kerja, Cari Karyawan Semudah Klik!',
    //     description: 'Misi kami adalah memberdayakan setiap usaha dan SDM di Indonesia untuk tumbuh dan berkembang lebih melalui simplisitas dan konsistensi',
    //     imagePath: '/images/asset-22.png',
    //     topButton: SmallTextIconButton(text: 'Posting Lowongan', onPress: () {}, icon: FontAwesomeIcons.playCircle),
    //     bottomButton: SmallTextIconButton(text: 'Cari Kerja', onPress: () {}, icon: FontAwesomeIcons.download),
    // ),
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
                height: 700,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollPhysics: const NeverScrollableScrollPhysics(),
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
                          vertical: 2.0, horizontal: 4.0),
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
