import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/pricing/pricing.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/config/responsive.dart';

class PricingDektop extends StatefulWidget {
  const PricingDektop({Key? key}) : super(key: key);

  @override
  _PricingDektopState createState() => _PricingDektopState();
}

class _PricingDektopState extends State<PricingDektop> {
  List<Section> _listSection = [];
  // new List<Section>();
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
        'lib/features/kukerja/landing_page/presentation/widgets/pricing/pricingData.json');
    final data = await json.decode(response);
    for (var h in data) {
      // Section section = Section(title: h['title'].toString());
      _listSection.add(h);
    }
    setState(() {
      _listSection = data["sections"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // print({'INI LIST DALAM': listSection});
    var screenSize = MediaQuery.of(context).size;
    // List<Section> listSection = [
    //   Section(
    //       title: 'Kelas Best Seller #1',
    //       category: 'Kategori: Web, Data & Digital Marketing',
    //       description:
    //           'Materi Disusun Oleh Tutor Dengan Pengalaman Lebih Dari 10 Tahun Di Berbagai Industri',
    //       courses: [
    //         Course(
    //             fileLocation: '/images/laptop.png',
    //             title: '1. Kelas Website Tanpa Coding',
    //             description:
    //                 'mampu membuat website company profile dan landing page untuk bisnis dan siap menjadi freelancer',
    //             level: 'All Level',
    //             prePrice: '1.250.000',
    //             finalPrice: '198.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/keranjang.png',
    //             title: '2. Praktek Langsung Dan Bangun Portofolio',
    //             description:
    //                 'Gak cuma teori, kelas di habiskerja juga mengajak kamu untuk praktek langsung',
    //             level: 'Advanced',
    //             prePrice: '498.000',
    //             finalPrice: '198.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/stock.png',
    //             title: '3. Manfaatkan Skill Untuk Berbisnis',
    //             description:
    //                 'Setelah selesai belajar, kamu akan diajarkan cara memaksimalkan skill untuk kepentingan bisnismu',
    //             level: 'Advanced',
    //             prePrice: '498.000',
    //             finalPrice: '198.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/facebook.png',
    //             title: '4. DIGITAL MARKETING: FB & INSTAGRAM ADS',
    //             description:
    //                 'mampu meningkatkan penjualan melalui iklan di facebook dan instagram',
    //             level: 'Advanced',
    //             prePrice: '498.000',
    //             finalPrice: '249.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/ads.png',
    //             title: '5. DIGITAL MARKETING: GOOGLE ADS',
    //             description:
    //                 'mampu memahami dan mempraktekkan teknik beriklan di Google Ads 2021',
    //             level: 'Advanced',
    //             prePrice: '498.000',
    //             finalPrice: '247.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/ngetik.png',
    //             title: '6. KELAS COPYWRITING',
    //             description:
    //                 'belajar copywriting untuk meningkatkan penjualan melalui berbagai media.',
    //             level: 'Advanced',
    //             prePrice: '498.000',
    //             finalPrice: '198.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ])
    //       ]),
    //   Section(
    //       title: 'Kelas Best Seller #2',
    //       category: 'Kategori: Desain & Animasi',
    //       description:
    //           'Materi Disusun Oleh Tutor Dengan Pengalaman Lebih Dari 10 Tahun Di Berbagai Industri',
    //       courses: [
    //         Course(
    //             fileLocation: '/images/adobe.png',
    //             title: 'KELAS DESAIN GRAFIS DENGAN PHOTOSHOP DAN CORELDRAW',
    //             description:
    //                 'mampu membuat desain grafis menggunakan CorelDRAW dan Photoshop.',
    //             level: 'All Level',
    //             prePrice: '491.000',
    //             finalPrice: '239.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/yellowman.png',
    //             title:
    //                 'KELAS ANIMASI MOTION GRAPHIC DENGAN ADOBE AFTER EFFECTS',
    //             description:
    //                 'Mampu membuat animasi motion graphic 2D menggunakan software After Effects.',
    //             level: 'All Level - New Class',
    //             prePrice: '296.000',
    //             finalPrice: '193.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/comingsoon.png',
    //             title: 'KELAS UI/UX WEBSITE DAN APLIKASI MOBILE',
    //             description:
    //                 'memahami dan mampu membuat desain UI/UX untuk website dan mobile Apps.',
    //             level: 'All Level',
    //             prePrice: '',
    //             finalPrice: '',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ])
    //       ]),
    //   Section(
    //       title: "Kelas Best Seller #3",
    //       category: 'Kategori: Investasi Dan Keuangan',
    //       description:
    //           'Materi Disusun Oleh Tutor Dengan Pengalaman Lebih Dari 10 Tahun Di Berbagai Industri',
    //       courses: [
    //         Course(
    //             fileLocation: '/images/saham.png',
    //             title: 'KELAS INVESTASI SAHAM',
    //             description:
    //                 'mampu berinvestasi dan menghasilkan profit konsisten setiap bulannya.',
    //             level: 'All Level',
    //             prePrice: '1.250.000',
    //             finalPrice: '296.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/crypto.png',
    //             title: 'KELAS INVESTASI CRYPTOCURRENCY',
    //             description:
    //                 'memahami apa itu cryptocurrency dan bagaimana cara berinvestasi yang tepat dan aman',
    //             level: 'All Level',
    //             prePrice: '1.250.000',
    //             finalPrice: '149.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/americanstock.png',
    //             title: 'KELAS INVESTASI SAHAM AMERIKA (US STOCKS)',
    //             description:
    //                 'mampu memahami dan mempraktekkan teknik beriklan di Google Ads 2021',
    //             level: 'All Level',
    //             prePrice: '956.000',
    //             finalPrice: '239.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/bandarmologi.png',
    //             title: 'KELAS BANDARMOLOGI',
    //             description:
    //                 'memahami rahasia analisis saham para bandar dalam mengontrol harga saham di bursa Indonesia',
    //             level: 'All Level',
    //             prePrice: '1.500.000',
    //             finalPrice: '299.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/comingsoon.png',
    //             title: 'KELAS PERSONAL FINANCES',
    //             description:
    //                 'membuat planning personal finances untuk keuangan yang lebih baik',
    //             level: 'All Level',
    //             prePrice: '',
    //             finalPrice: '',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/comingsoon.png',
    //             title: 'KELAS ACCOUNTING FOR BUSINESS',
    //             description:
    //                 'memahami prinsip akuntansi untuk pembukuan usaha UMKM',
    //             level: 'All Level',
    //             prePrice: '',
    //             finalPrice: '',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ])
    //       ]),
    //   Section(
    //       title: 'Kelas Best Seller #4',
    //       category: 'Kategori: Self Development & Career',
    //       description:
    //           'Materi Disusun Oleh Tutor Dengan Pengalaman Lebih Dari 10 Tahun Di Berbagai Industri',
    //       courses: [
    //         Course(
    //             fileLocation: '/images/agreement.png',
    //             title: 'ENGLISH FOR CAREER PREPARATION',
    //             description:
    //                 'mampu menyusun CV, cover letter dan melakukan interview berbahasa inggris.',
    //             level: 'All Level',
    //             prePrice: '398.000',
    //             finalPrice: '199.000',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/comingsoon.png',
    //             title: 'KELAS MENENTUKAN PILIHAN KARIR',
    //             description:
    //                 'belajar menganalisis kelebihan diri untuk menentukan pilihan karir yang paling sesuai.',
    //             level: 'All Level',
    //             prePrice: '',
    //             finalPrice: '',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ]),
    //         Course(
    //             fileLocation: '/images/comingsoon.png',
    //             title: 'KELAS PERSIAPAN CV DAN COVER LETTER',
    //             description:
    //                 'memahami strategi pembuatan CV dan cover letter untuk mendapatkan pekerjaan impian.',
    //             level: 'All Level',
    //             prePrice: '',
    //             finalPrice: '',
    //             benefits: [
    //               Benefit(
    //                   fileLocation: const Icon(Icons.local_attraction_rounded),
    //                   title: 'Sertifikat'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.chat_outlined),
    //                   title: 'Konsultasi'),
    //               Benefit(
    //                   fileLocation: const Icon(Icons.code),
    //                   title: 'Studi Kasus')
    //             ])
    //       ]),
    // ];

    return Column(
      children: [
        for (var section in _listSection)
          Column(
            children: [
              Column(children: [
                const SizedBox(height: 150),
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
                const SizedBox(height: 30),
              ]),
              SizedBox(
                width: screenSize.width * 0.75,
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: ResponsiveWidget.isHDScreen(context)
                      ? (screenSize.width * 0.75) /
                          3 /
                          (screenSize.height * 0.95)
                      : (screenSize.width * 0.75) /
                          3 /
                          (screenSize.height * 0.7),
                  crossAxisCount: 3,
                  children: [
                    for (var i in section.courses)
                      Container(
                        padding: const EdgeInsets.all(30),
                        margin: EdgeInsets.all(
                            ((screenSize.width * 0.6) / 3) * 0.03),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ResponsiveWidget.isHDScreen(context)
                                              ? 150
                                              : 200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(i.title.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),
                            Text(i.level.toString(),
                                // maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 14,
                                )),
                            const SizedBox(height: 20),
                            (i.prePrice.isNotEmpty
                                ? Text('Rp ${i.prePrice}',
                                    // maxLines: 2,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                    ))
                                : const SizedBox(height: 0)),
                            (i.prePrice.isNotEmpty
                                ? const SizedBox(height: 10)
                                : const SizedBox(height: 0)),
                            (i.finalPrice.isNotEmpty
                                ? Text(
                                    'Rp ${i.finalPrice}/ selamanya',
                                    // maxLines: 2,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ))
                                : const SizedBox(height: 0)),
                            (i.finalPrice.isNotEmpty
                                ? const SizedBox(height: 20)
                                : const SizedBox(height: 0)),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Color(0xffE5E5E5),
                            ),
                            const SizedBox(height: 20),
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
                                    onPressed: () {},
                                    icon: benefit.fileLocation,
                                    label: Text(benefit.title,
                                        style: const TextStyle(fontSize: 12)),
                                  )
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              height: 5,
                              thickness: 1,
                              color: Color(0xffE5E5E5),
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 25),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 19)),
                                            textStyle: MaterialStateProperty.all<TextStyle>(
                                                const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold))),
                                        child: const Text('Lihat Info'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () => {},
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    const Color(0xff00ff84)),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 19),
                                            ),
                                            textStyle: MaterialStateProperty
                                                .all<TextStyle>(const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        child: const Text('Daftar'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          )
      ],
    );
  }
}
