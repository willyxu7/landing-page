import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/widgets/heading_2.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';

import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/paragraph_widget.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  static const route = '/privacy-and-policy';

  const PrivacyAndPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavBarDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: ResponsiveWidget.isSmallScreen(context)
                  ? SizeConfig.screenWidth
                  : SizeConfig.screenWidth * 0.55,
              padding: ResponsiveWidget.isSmallScreen(context)
                  ? const EdgeInsets.all(16)
                  : const EdgeInsets.all(80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Heading2(text: 'Kebijakan Privasi'),
                  const SizedBox(height: 40),
                  ParagraphWidget(
                    'Adanya Kebijakan Privasi ini adalah komitmen nyata dari Kukerja untuk menghargai dan melindungi setiap data atau informasi pribadi Pengguna situs kukerja.id, situs-situs turunannya, serta aplikasi Kukerja (selanjutnya disebut sebagai "Situs").',
                    marginBottom: 24,
                  ),
                  ParagraphWidget(
                      'Kebijakan Privasi ini (beserta syarat-syarat penggunaan dari situs Kukerja sebagaimana tercantum dalam "Syarat dan Ketentuan" menetapkan dasar atas perolehan, pengumpulan, pengolahan, penganalisisan, penampilan, pembukaan, dan/atau segala bentuk pengelolaan yang terkait dengan data atau informasi yang Pengguna berikan kepada Kukerja atau yang Kukerja kumpulkan dari Pengguna, termasuk data pribadi Pengguna, baik pada saat Pengguna melakukan pendaftaran di Situs, mengakses Situs, maupun mempergunakan layanan-layanan pada Situs (selanjutnya disebut sebagai "data").',
                      marginBottom: 24),
                  ParagraphWidget(
                      'Dengan mengakses dan/atau mempergunakan layanan Kukerja, Pengguna menyatakan bahwa setiap data Pengguna merupakan data yang benar dan sah, serta Pengguna memberikan persetujuan kepada Kukerja untuk memperoleh, mengumpulkan, menyimpan, mengelola dan mempergunakan data tersebut sebagaimana tercantum dalam Kebijakan Privasi maupun Syarat dan Ketentuan Kukerja.',
                      marginBottom: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ParagraphWidget('A. Pengumpulan Data Privasi'),
                        ParagraphWidget('B. Penggunaan Data Privasi'),
                        ParagraphWidget('C. Pengaksesan Data Privasi'),
                        ParagraphWidget('D. Keamanan Data Privasi'),
                        ParagraphWidget('E. Informasi Transaksi'),
                        ParagraphWidget(
                          'F. Persetujuan',
                          marginBottom: 24,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ParagraphWidget(
                          'A. Pengumpulan Data Privasi',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Data privasi yang dikumpulkan merupakan informasi yang berisi syarat wajib sebagai pengguna Kukerja.id, baik untuk mengikuti seleksi perekrutan yang mana disebut sebagai pencari kerja atau untuk menyeleksi pencari kerja yang mana disebut sebagai pihak perekrut',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Data privasi yang dimaksud merupakan data pribadi berisi informasi pengguna pada saat melakukan pendaftaran berisi:',
                                marginBottom: 24,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ParagraphWidget('1. Nama;'),
                                    ParagraphWidget('2. Jenis Kelamin;'),
                                    ParagraphWidget('3. Alamat;'),
                                    ParagraphWidget('4. Pendidikan;'),
                                    ParagraphWidget('5. Nomor Handphone;'),
                                    ParagraphWidget(
                                      '6. Email.',
                                      marginBottom: 24,
                                    )
                                  ],
                                ),
                              ),
                              ParagraphWidget(
                                'Bagi pencari kerja diharapkan melengkapi dokumen pendukung yang berisi:',
                                marginBottom: 24,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ParagraphWidget(
                                        '1. Kartu Tanda Penduduk (KTP);'),
                                    ParagraphWidget(
                                        '2. Curriculum Vitae (CV);'),
                                    ParagraphWidget('3. Ijazah;'),
                                    ParagraphWidget(
                                      '4. Dokumen pelengkap lainnya;',
                                      marginBottom: 24,
                                    ),
                                  ],
                                ),
                              ),
                              ParagraphWidget(
                                'Bagi pihak perekrut diharapkan melengkapi dokumen pendukung yang barisi:',
                                marginBottom: 24,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ParagraphWidget(
                                      '1. Dokumen pelengkap lainnya;',
                                      marginBottom: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'B. Penggunaan Data Privasi',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Data privasi yang diunggah pada Kukerja.id adalah data yang dikumpulkan dan diolah sebagaimana mengikuti kebijakan sesuai keperluan dan prosedur pada Kukerja.id. Data privasi pencari kerja yang terkumpul akan diverifikasi dan disortir kelengkapannya oleh tim verifikator Kukerja.id, demi mempermudah pihak perekrut dalam menyeleksi dan mengakses sesuai kebutuhan. Data privasi pencari pekerja dibutuhkan guna memverifikasi serta melengkapi dokumen yang menjadi acuan pihak perekrut mengenai informasi pribadi, seperti identitas, CV, serta dokumen pendukung lainnya. Sedangkan, data privasi pihak perekrut dibutuhkan guna memverifikasi yang menjadi acuan bagi tim verifikator Kukerja.id bahwa perekrut berkomitmen mencari calon pekerja sesuai dengan kebutuhan perusahaan, retail maupun UMKM.',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Semua data yang dikumpulkan dengan cara pengunggahan dokumen yang berbentuk (portable document format) PDF dan JPEG.',
                                marginBottom: 24,
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'C. Pengaksesan Data Privasi',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Segala data privasi pencari kerja yang terkumpul akan terlihat dan dapat diakses terbatas hanya untuk tim verifikator Kukerja.id dan pihak perekrut sebagai pihak penyeleksi calon pekerja. Pihak perekrut tidak berwenang menjual, membagi atau menyalahgunakan data privasi pencari kerja kepada pihak lain diluar kebutuhan perekrutan.',
                                marginBottom: 24,
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'D. Keamanan Data Privasi',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Kukerja.id tidak pernah menjual, membagi atau menyalahgunakan data privasi pengguna Kukerja.id diluar wewenang kebutuhan pengolahan data.',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Segala data privasi akan dijaga keamanannya, namun harap diingat bahwa segala sistem keamanan tidak dapat diukur tingkat keamanannya. Kukerja.id menerapkan sistem enkripsi dan sistem lainnya yang lebih canggih untuk membatasi hak akses yang mengancam keamanan data privasi pengguna.',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Kukerja.id akan bekerja dengan segala upaya untuk melindungi keamanan data demi menjaga kepercayaan pengguna.',
                                marginBottom: 24,
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'E. Informasi Transaksi',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Demi keberlangsungan layanan, Kukerja.id menyediakan transaksi pembayaran yang dapat dilakukan untuk meningkatkan layanan dan integritas kepada pengguna.',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Kukerja.id juga bekerja sama dengan pihak ketiga untuk mempermudah pengguna melakukan transaksi pembayaran.',
                                marginBottom: 24,
                              ),
                              ParagraphWidget(
                                'Segala transaksi yang dilakukan pada Kukerja.id melalui pihak ketiga akan dijaga keamanannya mengenai informasi pribadi seperti nomor rekening, nomor kartu kredit, nomor atau ID pengguna dan sebagainya.',
                                marginBottom: 24,
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'F. Persetujuan',
                          marginBottom: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ParagraphWidget(
                                'Dengan menggunakan layanan Kukerja.id, pengguna menyetujui segala hal yang tertuang dalam kebijakan privasi ini. Kukerja.id tidak pernah melakukan pemaksaan jika pengguna keberatan mengikuti peraturan serta kebijakan didalamnya.',
                                marginBottom: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

