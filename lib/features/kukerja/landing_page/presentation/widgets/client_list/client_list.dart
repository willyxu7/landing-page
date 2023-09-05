import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/client_list/layout/client_logo.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/client_list/layout/client_logo_mobile.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../../../core/config/responsive.dart';
import 'layout/client_logo_desktop.dart';

class ClientList extends StatefulWidget {
  const ClientList({
    Key? key,
  }) : super(key: key);

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 120.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width * 0.85,
              // alignment: Alignment.center,
              child: AutoSizeText.rich(
                  const TextSpan(text: 'Bergabung bersama  ', children: [
                    TextSpan(
                      text: '2.000+ ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'bisnis ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'dan ',
                    ),
                    TextSpan(
                      text: '20.000+ ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'pekerja lainnya',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                  textAlign: TextAlign.center,
                  minFontSize:
                      ResponsiveWidget.isSmallScreen(context) ? 17 : 27),
            ),
          ],
        ),
        CarouselSlider(
            items: ResponsiveWidget.isSmallScreen(context)
                ? getClientLogoMobiles()
                : getClientLogoDesktops(),
            options: CarouselOptions(
              height: 150,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            )),
      ]),
    );
  }

  List<Widget> getClientLogoDesktops() {
    List<Widget> clientLogoDesktops = [
      ClientLogoDesktop(clientLogos: [
        ClientLogo(imagePath: 'assets/images/teh-2-daun.png'),
        ClientLogo(imagePath: 'assets/images/jims-honey.png'),
        ClientLogo(imagePath: 'assets/images/kamsia-bobba.png'),
        ClientLogo(imagePath: 'assets/images/hei-hei-bobba.png'),
        ClientLogo(imagePath: 'assets/images/logo-5.png'),
      ]),
      ClientLogoDesktop(clientLogos: [
        ClientLogo(imagePath: 'assets/images/geprek-demango.png'),
        ClientLogo(imagePath: 'assets/images/honda.png'),
        ClientLogo(imagePath: 'assets/images/kawasaki.png'),
        ClientLogo(imagePath: 'assets/images/mr-achiang.png'),
        ClientLogo(imagePath: 'assets/images/zprint.png'),
      ]),
      ClientLogoDesktop(clientLogos: [
        ClientLogo(imagePath: 'assets/images/bca-binance.png'),
        ClientLogo(imagePath: 'assets/images/dika.png'),
        ClientLogo(imagePath: 'assets/images/pondok-ale-ale.png'),
        ClientLogo(imagePath: 'assets/images/rs-mitra-medika.png'),
        ClientLogo(imagePath: 'assets/images/smartfren.png'),
      ]),
      ClientLogoDesktop(clientLogos: [
        ClientLogo(imagePath: 'assets/images/3second.png'),
        ClientLogo(imagePath: 'assets/images/grha.png'),
        ClientLogo(imagePath: 'assets/images/haji-cijantung.png'),
        ClientLogo(imagePath: 'assets/images/mega-mas-mandiri.png'),
        ClientLogo(imagePath: 'assets/images/pakita-jaya.png'),
      ]),
    ];
    return clientLogoDesktops;
  }

  List<Widget> getClientLogoMobiles() {
    List<Widget> clientLogoMobiles = [
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/teh-2-daun.png'),
        ClientLogo(imagePath: 'assets/images/jims-honey.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/kamsia-bobba.png'),
        ClientLogo(imagePath: 'assets/images/hei-hei-bobba.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/logo-5.png'),
        ClientLogo(imagePath: 'assets/images/geprek-demango.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/honda.png'),
        ClientLogo(imagePath: 'assets/images/kawasaki.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/mr-achiang.png'),
        ClientLogo(imagePath: 'assets/images/zprint.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/bca-binance.png'),
        ClientLogo(imagePath: 'assets/images/dika.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/pondok-ale-ale.png'),
        ClientLogo(imagePath: 'assets/images/rs-mitra-medika.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/smartfren.png'),
        ClientLogo(imagePath: 'assets/images/3second.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/grha.png'),
        ClientLogo(imagePath: 'assets/images/haji-cijantung.png'),
      ]),
      ClientLogoMobile(clientLogos: [
        ClientLogo(imagePath: 'assets/images/mega-mas-mandiri.png'),
        ClientLogo(imagePath: 'assets/images/pakita-jaya.png'),
      ]),
    ];
    return clientLogoMobiles;
  }
}
