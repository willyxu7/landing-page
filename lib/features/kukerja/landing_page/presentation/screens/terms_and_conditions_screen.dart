import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';

import '../../../../../core/config/responsive.dart';
import '../../../../../core/widgets/heading_2.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/nav_bar_drawer.dart';
import '../../../../../core/widgets/paragraph_widget.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String route = '/terms-and-conditions';

  const TermsAndConditionsScreen({Key? key}) : super(key: key);

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
                  const Heading2(text: 'Syarat & Kententuan'),
                  const SizedBox(height: 40),
                  ParagraphWidget(
                      'Syarat & ketentuan yang ditetapkan di bawah ini mengatur pemakaian jasa yang ditawarkan oleh PT. Sinergi Kukerja Indonesia terkait penggunaan situs kukerja.id. Pengguna disarankan membaca dengan seksama karena dapat berdampak kepada hak dan kewajiban Pengguna di bawah hukum.',
                      marginBottom: 24),
                  ParagraphWidget(
                      'Dengan mendaftar dan/atau menggunakan situs kukerja.id, maka pengguna dianggap telah membaca, mengerti, memahami dan menyetujui semua isi dalam Syarat & ketentuan. Syarat & ketentuan ini merupakan bentuk kesepakatan yang dituangkan dalam sebuah perjanjian yang sah antara Pengguna dengan PT. Sinergi Kukerja Indonesia. Jika pengguna tidak menyetujui salah satu, sebagian, atau seluruh isi Syarat & ketentuan, maka pengguna tidak diperkenankan menggunakan layanan di kukerja.id.',
                      marginBottom: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ParagraphWidget('A. Perubahan Ketentuang Penggunaan'),
                        ParagraphWidget('B. Hak Kekayaan Intelektual'),
                        ParagraphWidget('C. Definisi'),
                        ParagraphWidget('D. Pengguna'),
                        ParagraphWidget('E. Pendaftaran Pengguna'),
                        ParagraphWidget('F. Batasan Pertanggung Jawaban'),
                        ParagraphWidget('G. Pelepasan Kewajiban'),
                        ParagraphWidget('H. Perubahan Isi Situs'),
                        ParagraphWidget('I. Hukum yang Mengatur'),
                        ParagraphWidget(
                          'J. Pernyataan Anda',
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
                          'A. Perubahan Ketentuan Penggunaan',
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
                                  'Kukerja.id dapat setiap saat mengganti, menambah. atau mengurangi Ketentuan Penggunaan ini. Syarat dan ketentuan yang ada di halaman \"Syarat dan Ketentuan\" ini berlaku dan mengikat para pengguna situs Kukerja.id, baik sebagai pengguna terdaftar ataupun sekedar berkunjung melihat-lihat situs, pemasang iklan, perusahaan, maupun para pencari kerja. Kukerja.com menghimbau pengguna untuk melihat dan memperoleh informasi secara berkala untuk mematuhi hal-hal yang telah ditetapkan. Dengan mengakses atau menggunakan situs kami, maka setiap pengguna dianggap telah menerima, mengerti, memahami, menyetujui, serta sepakat untuk mematuhi semua isi dalam Syarat dan Ketentuan di bawah ini. Jika, pengguna tidak setuju atas apa yang tertera di bawah ini, Kukerja.id tidak melarang pengguna untuk meninggalkan situs Kukerja.id.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'B. Hak Kekayaan Intelektual',
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
                                  'Setiap logo dan/atau aplikasi logo dan/atau merk atas layanan, konten, produk, dan fitur yang terdapat di Kukerja.id ini berada dibawah perlindungan hukum yang berlaku di Indonesia.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'C. Definisi',
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
                                  'Kukerja.id adalah suatu perusahaan yang bergerak di bidang aplikasi rekrutmen online dengan memberikan solusi teknologi terbaik bagi usaha kecil, perusahaan berkembang dan lembaga rekrutmen bermarkas di Pontianak Kota, Indonesia. Pengguna tidak dibenarkan untuk menggunakan, mengimplementasikan, dan mengaplikasikan logo dan/atau aplikasi logo tanpa persetujuan tertulis sebelumnya dari Kukerja.id.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'D. Pengguna',
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
                                  'Pengguna adalah para pihak yang menggunakan jasa Kukerja.id, termasuk dan tidak terbatas pada pemasang iklan, pencari kerja (job seekers) ataupun pihak yang sekedar berkunjung melihat-lihat situs.',
                                  marginBottom: 24),
                              ParagraphWidget(
                                  'Pengguna harus setidaknya merupakan Perorangan atau Badan Hukum Perusahaan seperti yang disebutkan di bawah ini, dan mencakup semua orang yang menjelajah dan melihat situs, maupun semua orang yang memasang iklan apa pun dan mencantumkan lowongan kerja apapun di situs Kukerja.id.',
                                  marginBottom: 24),
                              Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(fontSize: 18, color: Colors.black),
                                        children: [
                                      TextSpan(
                                          text: "'Individu'",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic)),
                                      TextSpan(
                                          text:
                                              ' - Layanan disediakan hanya untuk individu yang mampu terikat ke dalam perjanjian legal di bawah undang-undang Indonesia.')
                                    ])),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(fontSize: 18, color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "'Entitas Korporat'",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic)),
                                          TextSpan(
                                              text:
                                              ' - Layanan disediakan untuk perusahaan dan badan hukum usaha. Setiap orang yang memakai Layanan atas nama entitas korporat mewakili bahwa dirinya telah memiliki wewenang untuk mengikat entitas korporat terhadap Syarat dan Ketentuan yang ditetapkan dalam Perjanjian.')
                                        ])),
                              ),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'E. Pendaftaran Pengguna',
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
                                  'Jika Anda ingin melamar pekerjaan di salah satu lowongan yang terdaftar di situs, maka Anda harus mendaftar terlebih dahulu dan mempunyai akun Kukerja.id dimana Anda setelahnya dapat memasukkan lamaran ke berbagai lowongan. Untuk mendaftar, Anda perlu memasukkan beberapa informasi pribadi seperti nama lengkap, alamat, email, CV dan lain-lain.',
                                  marginBottom: 24),
                              ParagraphWidget(
                                  'Jika Anda sudah mempunyai akun Kukerja.id, Anda tidak perlu melakukan pendaftaran lagi.',
                                  marginBottom: 24),
                              ParagraphWidget(
                                  'Bagi perusahaan, untuk bisa memasang iklan lowongan pekerjaan. Anda diperlukan untuk mendaftarkan perusahaan Anda terlebih dahulu dengan mengisi nama perusahaan, email perusahaan/pribadi, logo perusahaan, profil perusahaan, dan detail lowongan pekerjaan yang akan ditayangkan di aplikasi kami. Kami menggunakan alamat email sebagai ID login, jika Anda sudah mendaftarkan perusahaan Anda dengan satu email, maka Anda tidak perlu mendaftarkan data pemasang iklan terlebih dahulu dan bisa langsung memasang iklan lowongan kerja yang nantinya akan di verifikasi oleh tim Kukerja apakah iklan tersebut layak atau tidak . Kukerja juga berhak menayangkan kembali iklan lowongan kerja Anda yang ada di internet seperti (google, job portal, dan media sosial), media elektronik, atau cetak ke Kukerja.id. Anda juga bisa melakukan pengajuan untuk menonaktifkan akun atau iklan Anda ke tim Kukerja melalui email Employer@Kukerja.id atau Whatsapp +62813 4768 3038.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'F. Batasan Pertanggung Jawaban',
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
                                  'Anda dengan ini menyatakan sepakat dan setuju bahwa sejauh mana diizinkan oleh peraturan yang berlaku:',
                                  marginBottom: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(16)
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            ParagraphWidget('1. '),
                                            ParagraphWidget('Jasa dan konten dari situs ini disediakan dengan ketentuan “sebagaimana adanya” dan “sebagaimana tersedia”. Kami dengan ini menyatakan dengan tegas bahwa kami tidak melakukan penjaminan atau garansi apapun baik secara tegas maupun tersirat, sehubungan dengan dapat diperdagangkan suatu produk atau jasa, atau kesiapan suatu produk dan jasa yang kami sediakan untuk suatu tujuan tertentu dan terhadap pelanggaran yang berlaku;', marginBottom: 8,),
                                          ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('2. '),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  ParagraphWidget('Kami tidak menjamin bahwa'),
                                                  ParagraphWidget('(i) Fungsi dan jasa yang disediakan dari situs ini akan bebas dari gangguan atau kesalahan apapun termasuk keamanan dari situs ini;'),
                                                  ParagraphWidget('(ii) Kelalaian akan di perbaiki; atau'),
                                                  ParagraphWidget('(iii) Situs ini atau server yang menyediakan jasa bebas dari virus atau komponen membahayakan;', marginBottom: 8,),
                                                ],
                                              )
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('3. '),
                                              ParagraphWidget('Kami tidak menjamin mengenai ketepatan, keaslian, integritas atau kualitas dari konten, situs atau sumber yang ada pada dan dari situs, termasuk, namun tidak terbatas pada penjaminan konten, situs atau sumber yang bebas dari bahan yang dapat menyerang, tidak senonoh, atau dapat diperdebatkan;', marginBottom: 8,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('4. '),
                                              ParagraphWidget('Tiap bahan yang diunduh atau diperoleh melalui penggunaan jasa ini adalah tanggung jawab dan risiko anda sendiri. Anda akan bertanggung jawab sepenuhnya terhadap kerusakan sistem komputer atau kehilangan data yang diakibatkan dari pengunduhan materi yang ada.', marginBottom: 24,),
                                            ]
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ParagraphWidget(
                                  'Kami tidak akan bertanggung jawab terhadap kerusakan dari penggunaan situs ini baik secara langsung maupun tidak langsung, baik khusus atau tambahan sebagai penggunaan situs ini atau penggunaan dari tautan yang ada pada situs walaupun kami telah diberitahu mengenai kemungkinan kerugian atau kerusakan yang dapat terjadi. Perbaikan yang dapat diberikan pada anda adalah pemberhentian dari penggunaan situs ini.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'G. Pelepasan Kewajiban',
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
                                  'Berdasarkan aturan hukum yang diizinkan, perusahaan, perusahaan induk, anak perusahaan, perusahaan terkait, direktur, staff, pegawai, pembantu, pemasok, agen atau orang yang ditugaskan, karena peristiwa apa pun, diberikan kewajiban atas:',
                                  marginBottom: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(16)
                                      },
                                      children: [
                                        TableRow(
                                            children: [
                                              ParagraphWidget('1. '),
                                              ParagraphWidget('Segala kerusakan akibat hukuman, insidental, atau karena akibat atau kerugian terkait dengan perjanjian ini termasuk kerugian ekonomis (mencakup, namun tidak terbatas kepada kehilangan pendapatan, keuntungan, kontrak, bisnis atau penghematan yang diperkirakan); atau', marginBottom: 8,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('2. '),
                                              ParagraphWidget('Hilangnya maksud baik atau reputasi; atau', marginBottom: 8,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('3. '),
                                              ParagraphWidget('Segala kerusakan khusus, tidak langsung, atau karena akibat yang timbul dari sehubungan dengan perjanjian ini, mencakup namun tidak terbatas kepada tindakan pelanggaran kontrak, tindakan di bawah kesalahan, kecerobohan, fitnah, pelanggaran hak cipta, pelanggaran merek dagang, penukaran, pelanggaran desain industri terdaftar, pelanggaran paten, pelanggaran kepercayaan; atau', marginBottom: 8,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('4. '),
                                              ParagraphWidget('Segala kewajiban hukum adat; atau', marginBottom: 8,),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              ParagraphWidget('5. '),
                                              ParagraphWidget('Dengan segala cara yang lain.', marginBottom: 8,),
                                            ]
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ParagraphWidget(
                                  'Dengan tunduk pada pembatasan yang disebut di atas, tidak ada dalam perjanjian ini yang dianggap membatasi atau mengecualikan kewajiban perusahaan terhadap perjanjian yang keliru, atau kematian atau cedera perseorangan yang diakibatkan oleh kelalaian perusahaan atau kelalaian pembantu, agen, atau pegawai perusahaan. Untuk menghindari keragu-raguan, perusahaan tidak dikenakan dan tidak akan dikenakan akibat tindakan atau kelalaian provider lain atas layanan telekomunikasi atau akibat kerusakan atau kegagalan jaringan dan peralatan mereka.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'H. Perubahan Isi Situs',
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
                                  'Kukerja.id berhak memperbaharui atau mengubah situs www.Kukerja.id secara rutin dan berkala dan setiap saat dapat memperbaharui atau mengubah tampilan dan isinya, demi memberi pelayanan yang lebih baik kepada setiap pengguna.',
                                  marginBottom: 24),
                              ParagraphWidget(
                                  'Apabila sangat dibutuhkan, Kukerja dapat menghentikan akses ke situs www.kukerja.id atau menutup situs sementara waktu untuk jangka waktu yang tidak tertentu.',
                                  marginBottom: 24),
                              ParagraphWidget(
                                  'Informasi mengenai pengguna dan kunjungan pengguna ke situs Kukerja.id mempunyai hak untuk mengolah informasi mengenai pengguna sesuai dengan kebijakan yang tercantum di dalam Kebijakan Privasi. Dengan menggunakan situs kami, pengguna setuju atas pemrosesan tersebut dan menjamin semua data yang diberikan adalah benar.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'I. Hukum yang Mengatur',
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
                                  'Syarat dan Ketentuan situs www.Kukerja.id ini dan hubungan pengguna dengan kami wajib tunduk, diatur, dan patuh menurut hukum dan Undang-Undang Republik Indonesia. Serta, pengguna juga sepakat terikat pada yuridiksi hukum Negara ini.',
                                  marginBottom: 24),
                            ],
                          ),
                        ),
                        ParagraphWidget(
                          'J. Pernyataan Anda',
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
                                  'Anda mengakui bahwa kami adalah perusahaan teknologi, bukan perusahaan rekruitmen, bukan penyedia jasa tenaga kerja atau pun outsourching dan lain lain. Semua jenis lowongan dan pekerjaan disediakan oleh pihak ketiga independent yang tidak dipekerjakan oleh kami. Dengan melanjutkan akses atau penggunaan terhadap aplikasi KUKERJA dan/atau layanan, anda setuju untuk tunduk dan mematuhi semua ketentuan peraturan perundang-undangan terkait dan ketentuan penggunaan ini, termasuk semua perubahannya dan ketentuan penggunaan dari setiap penyedia layanan, penyedia konten pihak ketiga , penyedia penawaran atau penyedia metode pembayaran. Segera hentikan akses atau penggunaan aplikasi kukerja dan/atau layanan jika anda tidak setuju dengan bagian apapun dari ketentuan penggunaan ini.',
                                  marginBottom: 24),
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
