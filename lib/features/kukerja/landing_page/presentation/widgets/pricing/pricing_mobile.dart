import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/pricing/pricing.model.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/config/responsive.dart';

class PricingMobile extends StatefulWidget {
  const PricingMobile({Key? key}) : super(key: key);

  @override
  _PricingMobileState createState() => _PricingMobileState();
}

class _PricingMobileState extends State<PricingMobile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    List<Section> listSection = [
      Section(
          title: 'Kelas Best Seller #1',
          category: 'Kategori: Web, Data & Digital Marketing',
          description:
              'Materi Disusun Oleh Tutor Dengan Pengalaman Lebih Dari 10 Tahun Di Berbagai Industri',
          courses: [
            Course(
                fileLocation: '/images/laptop.png',
                title: '1. Kelas Website Tanpa Coding',
                description:
                    'mampu membuat website company profile dan landing page untuk bisnis dan siap menjadi freelancer',
                level: 'All Level',
                prePrice: '1.250.000',
                finalPrice: '198.000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ]),
            Course(
                fileLocation: '/images/keranjang.png',
                title: '2. Praktek Langsung Dan Bangun Portofolio',
                description:
                    'Gak cuma teori, kelas di habiskerja juga mengajak kamu untuk praktek langsung',
                level: 'Advanced',
                prePrice: '498000',
                finalPrice: '198000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ]),
            Course(
                fileLocation: '/images/stock.png',
                title: '3. Manfaatkan Skill Untuk Berbisnis',
                description:
                    'Setelah selesai belajar, kamu akan diajarkan cara memaksimalkan skill untuk kepentingan bisnismu',
                level: 'Advanced',
                prePrice: '498000',
                finalPrice: '198000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ]),
            Course(
                fileLocation: '/images/facebook.png',
                title: '4. DIGITAL MARKETING: FB & INSTAGRAM ADS',
                description:
                    'mampu meningkatkan penjualan melalui iklan di facebook dan instagram',
                level: 'Advanced',
                prePrice: '498.000',
                finalPrice: '249.000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ]),
            Course(
                fileLocation: '/images/ads.png',
                title: '5. DIGITAL MARKETING: GOOGLE ADS',
                description:
                    'mampu memahami dan mempraktekkan teknik beriklan di Google Ads 2021',
                level: 'Advanced',
                prePrice: '498000',
                finalPrice: '247.000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ]),
            Course(
                fileLocation: '/images/ngetik.png',
                title: '6. KELAS COPYWRITING',
                description:
                    'belajar copywriting untuk meningkatkan penjualan melalui berbagai media.',
                level: 'Advanced',
                prePrice: '498000',
                finalPrice: '198000',
                benefits: [
                  Benefit(
                      fileLocation: const Icon(Icons.local_attraction_rounded),
                      title: 'Sertifikat'),
                  Benefit(
                      fileLocation: const Icon(Icons.chat_outlined),
                      title: 'Konsultasi'),
                  Benefit(
                      fileLocation: const Icon(Icons.code),
                      title: 'Studi Kasus')
                ])
          ])
    ];
    return Column(
      children: [
        for (var section in listSection)
          Column(
            children: [
              Column(children: [
                Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width * 0.85
                      : ResponsiveWidget.isMediumScreen(context)
                          ? screenSize.width * 0.85
                          : screenSize.width * 0.65,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: AutoSizeText(section.title,
                      maxLines: ResponsiveWidget.isSmallScreen(context)
                          ? 3
                          : ResponsiveWidget.isMediumScreen(context)
                              ? 3
                              : 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize:
                              ResponsiveWidget.isSmallScreen(context) ? 30 : 45,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width * 0.85
                      : ResponsiveWidget.isMediumScreen(context)
                          ? screenSize.width * 0.85
                          : screenSize.width * 0.65,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(section.category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color(0xff0b7c15),
                          fontSize:
                              ResponsiveWidget.isSmallScreen(context) ? 16 : 20,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width * 0.85
                      : ResponsiveWidget.isMediumScreen(context)
                          ? screenSize.width * 0.85
                          : screenSize.width * 0.65,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                  child: Text(section.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ResponsiveWidget.isSmallScreen(context)
                              ? 14
                              : 16)),
                ),
              ]),
              SizedBox(
                width: screenSize.width * 0.85,
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: screenSize.width *
                      0.85 /
                      (ResponsiveWidget.isMediumScreen(context) ? 2 : 1) /
                      (ResponsiveWidget.isMediumScreen(context)
                          ? screenSize.height * 0.60
                          : screenSize.height * 0.85),
                  crossAxisCount:
                      ResponsiveWidget.isMediumScreen(context) ? 2 : 1,
                  children: [
                    for (var i in section.courses)
                      Container(
                        padding: EdgeInsets.all(
                            ResponsiveWidget.isSmallScreen(context) ? 15 : 30),
                        margin: EdgeInsets.all(((screenSize.width * 0.6) /
                                (ResponsiveWidget.isSmallScreen(context)
                                    ? 1
                                    : 3)) *
                            0.03),

                        // height: double.infinity,
                        // width: double.infinity,
                        width: ResponsiveWidget.isMediumScreen(context) ? 2 : 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment:
                                ResponsiveWidget.isSmallScreen(context)
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image(
                                          image: AssetImage(i.fileLocation),
                                          fit: BoxFit.cover,
                                          height:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? screenSize.height * 0.2
                                                  : screenSize.height * 0.13
                                          //  ResponsiveWidget.isSmallScreen(context)
                                          //     ? 100
                                          //     : 125,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 15
                                          : 20),
                              SizedBox(
                                width: screenSize.width *
                                    0.85 /
                                    (ResponsiveWidget.isMediumScreen(context)
                                        ? 2
                                        : 1),
                                height: 45,
                                child: AutoSizeText(i.title.toString(),
                                    maxLines: 2,
                                    minFontSize: 15,
                                    textAlign:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? TextAlign.center
                                            : TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 5
                                          : 10),
                              Text(i.level.toString(),
                                  // maxLines: 2,
                                  textAlign:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? TextAlign.center
                                          : TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 10
                                          : 15),
                              Text('Rp${i.prePrice}',
                                  // maxLines: 2,
                                  textAlign:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? TextAlign.center
                                          : TextAlign.left,
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                  )),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 5
                                          : 10),
                              Text(
                                  'Rp ${i.finalPrice}/ selamanya',
                                  // maxLines: 2,
                                  textAlign:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? TextAlign.center
                                          : TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 10
                                          : 20),
                              const Divider(
                                height: 5,
                                thickness: 1,
                                color: Color(0xffE5E5E5),
                              ),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 5
                                          : 15),
                              Wrap(
                                children: [
                                  for (var benefit in i.benefits)
                                    TextButton.icon(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.only(
                                                  top: 0,
                                                  left: 0,
                                                  bottom: 0,
                                                  right: 25)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black)),

                                      // style: const TextButton(
                                      //     padding: EdgeInsets.all(0)),
                                      onPressed: () {},
                                      icon: benefit.fileLocation,
                                      label: Text(benefit.title,
                                          style: const TextStyle(fontSize: 12)),
                                    )
                                ],
                              ),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 5
                                          : 15),
                              const Divider(
                                height: 5,
                                thickness: 1,
                                color: Color(0xffE5E5E5),
                              ),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 10
                                          : 20),
                              Flexible(
                                  child: RichText(
                                text: TextSpan(
                                  text: 'Goals: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: (i.description.toString()),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black)),
                                  ],
                                ),
                              )),
                              SizedBox(
                                  height:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 20
                                          : 25),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          ResponsiveWidget.isSmallScreen(
                                                  context)
                                              ? CrossAxisAlignment.center
                                              : CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () => {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      const Color(0xff00ff84)),
                                              foregroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      Colors.black),
                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      horizontal: (ResponsiveWidget.isSmallScreen(context)
                                                          ? 14
                                                          : 24),
                                                      vertical: (ResponsiveWidget.isSmallScreen(context)
                                                          ? 14
                                                          : 19))),
                                              textStyle: MaterialStateProperty.all<TextStyle>(
                                                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                          child:
                                              const AutoSizeText('Lihat Info'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          ResponsiveWidget.isSmallScreen(
                                                  context)
                                              ? CrossAxisAlignment.center
                                              : CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () => {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      const Color(0xff00ff84)),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        (ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? 14
                                                            : 24),
                                                    vertical: (ResponsiveWidget
                                                            .isSmallScreen(
                                                                context)
                                                        ? 14
                                                        : 19)),
                                              ),
                                              textStyle:
                                                  MaterialStateProperty.all<
                                                          TextStyle>(
                                                      const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                          child: const AutoSizeText('Daftar'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
