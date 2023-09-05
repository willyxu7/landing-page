import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/accordion.dart';
import 'package:kukerja_web/core/widgets/section_header.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/activity_type_util.dart';
import '../../../../activity/data/models/requests/activity_extra_request.dart';
import '../../../../activity/data/models/requests/activity_request.dart';
import '../../../../activity/domain/usecases/post_activity_use_case.dart';

class FrequentlyAskedQuestion extends StatelessWidget {
  const FrequentlyAskedQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void postFAQActivity() {
      PostActivityUseCase.exec(ActivityRequest(
          type: ActivityTypeUtil.webFrequentlyAskedQuestion,
          extra: ActivityExtraRequest(
              state: 'tap',
              widget: 'frequently asked question',
              screen: 'home')));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      child: Column(children: [
        const SectionHeader(text: 'Frequently Asked Question'),
        const SizedBox(
          height: 30,
        ),
        Container(
            width: ResponsiveWidget.isSmallScreen(context)
                ? SizeConfig.screenWidth * 0.85
                : ResponsiveWidget.isMediumScreen(context)
                    ? SizeConfig.screenWidth * 0.55
                    : SizeConfig.screenWidth * 0.55,
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Accordion(
                    title: 'Bagaimana cara membuat lowongan?',
                    textSpans: const [
                      TextSpan(
                          text:
                              'Untuk membuat lowongan kerja, pastikan Anda telah memiliki akun yang terdaftar di Kukerja sebagai pemberi kerja. Jika sudah, silahkan pilih menu Buat Lowongan, kemudian isi data sesuai dengan informasi pekerjaan Anda, tekan Post. Lowongan anda akan segera diterbitkan dan aktif di platform Kukerja.'),
                    ],
                    onTap: postFAQActivity),
                Accordion(
                    title:
                        'Bagaimana cara melamar kerja ke lowongan yang tersedia?',
                    textSpans: const [
                      TextSpan(
                          text:
                              'Pastikan Anda telah memiliki akun yang terdaftar sebagai pencari kerja. Untuk melihat lowongan, pilih halaman Pekerjaan , dan pilih lowongan yang Anda minati. Sebelum melamar, baca dengan seksama detail informasi pekerjaan Anda. Apabila ingin melamar, silahkan tekan pilihan Lamar Sekarang. ')
                    ],
                    onTap: postFAQActivity),
                Accordion(
                    title: 'Cara Mengatur CV',
                    textSpans: const [
                      TextSpan(
                          text:
                              'Pilih Profil, kemudian pilih Atur CV, isi CV Anda dengan informasi yang sesuai. Apabila selesai, silahkan pilih Upload. CV Anda akan ditampilkan pada saat Anda melamar kerja.')
                    ],
                    onTap: postFAQActivity),
                Accordion(
                    title: 'Akun Bisnis Yang Terverifikasi',
                    textSpans: const [
                      TextSpan(
                          text:
                              'Untuk dapat menjadi bisnis yang terverifikasi, Anda perlu untuk melengkapi data dan identitas usaha serta penanggung jawab yang dapat kami hubungi. Apabila telah selesai, maka tim kami akan melakukan proses verifikasi maksimal 1x24 jam.')
                    ],
                    onTap: postFAQActivity),
              ],
            )),
      ]),
    );
  }
}
