import 'package:flutter/material.dart';

class TalentPoolTerms extends StatelessWidget {
  const TalentPoolTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'SURAT PERJANJIAN KEMITRAAN KUKERJA (TALENT POOL)',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        const Center(
          child: Text(
            'KETENTUAN UMUM',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Persyaratan yang tertera dalam Perjanjian Kerjasama Kemitraan ini (Perjanjian) mengatur hubungan antara anda, perorangan (Mitra) dan PT Sinergi Kukerja Indonesia, yang beralamat di Jl. Purnama, Komplek Purnama Anggrek 1 no 14, Kelurahan Parit Tokaya, Kecamatan Pontianak Selatan, Kalimantan Barat 78113, Indonesia (SKI), dengan ketentuan-ketentuan sebagai tertera dibawah ini yang dituangkan dalam bentuk Kontrak Elektronik.',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
        const Text(
          'Definisi-definisi sebagaimana disebutkan dibawah ini berlaku dalam Perjanjian ini,',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text(
              'a.	Akun adalah akun yang didapatkan dan atas nama Mitra setelah Mitra mendaftarkan diri melalui Aplikasi;',
              textAlign: TextAlign.justify,
            ),
            Text(
              'b.	Aplikasi adalah aplikasi elektronik dengan merek dagang KUKERJA yang dikelola dan dimiliki oleh SKI;',
              textAlign: TextAlign.justify,
            ),
            Text(
              'c.	SKI adalah PT Sinergi Kukerja Indonesia, yang beralamat di Jl. Purnama, Komplek Purnama Anggrek 1 no 14, Kelurahan Parit Tokaya, Kecamatan Pontianak Selatan, Kalimantan Barat 78113, Indonesia selaku pemilik Aplikasi yang dimanfaatkan konsumen yang telah terdaftar untuk memperoleh jasa penyediaan tenaga kerja atau jasa lainnya;',
              textAlign: TextAlign.justify,
            ),
            Text(
              'd.	SNC atau PT Sinergi Nusantara Capital adalah sebuah perusahaan yang bekerjasama dengan SKI yang melakukan kegiatan usaha penyelengaraan sistem uang elektronik;',
              textAlign: TextAlign.justify,
            ),
            Text(
              'e.	Mitra adalah pihak yang mendaftar sebagai tenaga kerja yang siap kerja apabila ada panggilan atau jasa lainnya melalui Aplikasi.',
              textAlign: TextAlign.justify,
            ),
            Text(
              'f.	Ponsel Pintar adalah telepon selular yang dapat terhubung dengan Aplikasi;',
              textAlign: TextAlign.justify,
            ),
            Text(
              'g.	Persyaratan adalah syarat dan ketentuan Perjanjian ini atau syarat dan ketentuan lain yang diberlakukan oleh SKI maupun syarat dan ketentuan untuk penggunaan Aplikasi maupun fitur fitur didalam Aplikasi (sebagaimana berlaku dan termasuk namun tidak terbatas kepada setiap syarat dan ketentuan yang diberlakukan oleh SKI atau SNC sehubungan dengan penggunaan Aplikasi oleh Mitra dan/atau sehubungan dengan setiap penggunaan sistem uang elektronik);',
              textAlign: TextAlign.justify,
            ),
          ]),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            '1. HUBUNGAN KERJASAMA',
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1. ',
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Perjanjian kerjasama ini berlaku efektif sejak tanggal disetujuinya kontrak ini oleh Mitra. Dengan ini Mitra memberikan persetujuannya atas syarat dan ketentuan yang tercantum di dalam perjanjian kerjasama ini dengan cara melakukan tindakan mengklik persetujuan secara elektronik atas Perjanjian ini, mengakses dan menggunakan Aplikasi, Mitra akan diartikan telah setuju untuk terikat oleh Persyaratan, yang merupakan sebuah hubungan kontraktual kerja-sama antara Mitra dan SKI. Mitra mempunyai kewajiban untuk mentaati setiap kebijakan dalam Persyaratan dalam pelaksanaan Perjanjian ini. Dengan memberikan persetujuan atas perjanjian kerjasama ini, Mitra juga memberikan persetujuan atas (i) hubungan kerjasama antara Mitra dengan (a) SKI sehubungan dengan pendaftaran dan penggunaan Aplikasi dan (b) SNC sehubungan dengan setiap penggunaan sistem uang elektronik dalam penyediaan jasa yang dilakukannya melalui Aplikasi, dan (ii) setiap syarat dan ketentuan yang diberlakukan oleh SKI, sebagaimana dapat dirubah atau ditambahkan oleh SKI dari waktu ke waktu, sehubungan dengan pendaftaran Akun dan penggunaan Aplikasi, sebagaimana berlaku, sebagaimana diinformasikan atau diumumkan kepada Mitra melalui media elektronik ataupun media komunikasi lain yang dipilih oleh SKI.',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      'Apabila Mitra tidak setuju dengan Persyaratan ini, Mitra dapat memilih untuk tidak mengakses atau menggunakan Aplikasi. Mitra setuju bahwa SKI dapat secara langsung menghentikan penggunaan Aplikasi oleh Mitra, atau secara umum berhenti menawarkan atau menolak akses Mitra kedalam Aplikasi atau bagian mana pun dari Aplikasi, kapan pun untuk alasan apa pun.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '2. ',
              ),
              Flexible(
                child: Text(
                  'SKI, atas dasar pertimbangannya sendiri, dapat mengubah atau menambahkan ketentuan Perjanjian ini dan dapat menginformasikan perubahan terhadap Persyaratan yang diberlakukan dari waktu ke waktu. Perubahan atau penambahan atas Perjanjian ini atau Persyaratan tersebut akan berlaku setelah perubahan atau penambahan Persyaratan tersebut diumumkan melalui media elektronik ataupun media komunikasi lain yang dipilih oleh SKI yang dapat mencakup perubahan atau penambahan kebijakan yang sudah ada dalam Perjanjian ini atau Persyaratan atau syarat dan ketentuan tambahan. Mitra menyetujui bahwa akses atau penggunaan Mitra yang berkelanjutan atas Aplikasi maupun kelanjutan kerjasama Mitra setelah tanggal pengumuman atas perubahan Persyaratan akan diartikan bahwa Mitra setuju untuk terikat oleh Persyaratan, sebagaimana telah diubah atau ditambahkan.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '3. ',
              ),
              Flexible(
                child: Text(
                  'SKI, atas dasar pertimbangannya sendiri, dapat mengubah atau menambahkan ketentuan Perjanjian ini dan dapat menginformasikan perubahan terhadap Persyaratan yang diberlakukan dari waktu ke waktu. Perubahan atau penambahan atas Perjanjian ini atau Persyaratan tersebut akan berlaku setelah perubahan atau penambahan Persyaratan tersebut diumumkan melalui media elektronik ataupun media komunikasi lain yang dipilih oleh SKI yang dapat mencakup perubahan atau penambahan kebijakan yang sudah ada dalam Perjanjian ini atau Persyaratan atau syarat dan ketentuan tambahan. Mitra menyetujui bahwa akses atau penggunaan Mitra yang berkelanjutan atas Aplikasi maupun kelanjutan kerjasama Mitra setelah tanggal pengumuman atas perubahan Persyaratan akan diartikan bahwa Mitra setuju untuk terikat oleh Persyaratan, sebagaimana telah diubah atau ditambahkan.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '4. ',
              ),
              Flexible(
                child: Text(
                  'Bergantung pada kepatuhan Mitra terhadap Persyaratan, SKI, melalui hubungan kontraktual kerja-sama ini, memberi Mitra lisensi terbatas, non-eksklusif, tidak dapat disublisensikan, tidak dapat dicabut, dan tidak dapat dialihkan untuk: (i) mengakses dan menggunakan Aplikasi pada perangkat Ponsel Pintar yang dimiliki atau dikuasai oleh Mitra semata-mata terkait dengan penggunaan Mitra atas Aplikasi; dan (ii) mengakses dan menggunakan konten/isi, informasi dan materi terkait yang dapat disediakan melalui Aplikasi, dan semata-mata untuk Mitra sebagai penggunaan pribadi.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const Text(
          '   Aplikasi dan semua hak yang terkait dengan Aplikasi merupakan dan akan tetap menjadi milik SKI. Hak apa pun yang tidak diberikan secara tegas dalam Perjanjian ini merupakan hak SKI sebagai pemilik dari Aplikasi. Penggunaan Mitra atas Aplikasi maupun pemberian hak oleh SKI kepada Mitra atas penggunaan Aplikasi, tidak dapat diartikan menyatakan atau memberi Mitra hak kepemilikan apa pun atas Aplikasi.',
          textAlign: TextAlign.justify,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '5. ',
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Untuk dapat disetujui menjadi Mitra, Mitra diwajibkan untuk memenuhi persyaratan yang ditentukan oleh SKI sebagai berikut:',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '5.1. Memberikan jasa tenaga kerja sesuai dengan data yang telah di isi pada saat pendaftaran diri sebagai mitra di dalam aplikasi.',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '5.2. Memiliki rekening pada Bank yang direkomendasikan oleh SKI;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '5.3. Mempunyai catatan prestasi yang baik dan tidak pernah masuk dalam daftar hitam Kepolisian Republik Indonesia;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '5.4. Berjanji untuk, pada setiap saat, memenuhi semua syarat dan ketentuan dalam Perjanjian ini, Persyaratan lain dan kualifikasi minimum yang akan dijelaskan secara terpisah namun tetap menjadi kesatuan yang tidak terpisahkan dalam perjanjian ini.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '   Mitra menyetujui bahwa KUKERJA, atas dasar pertimbangannya sendiri, mempunyai hak untuk memberlakukan syarat-syarat tambahan selain yang disebutkan diatas, termasuk namun tidak terbatas kepada meminta Mitra untuk menyerahkan barang atau dokumen tambahan untuk disimpan oleh KUKERJA, maupun, apabila diwajibkan oleh peraturan perundang-undangan yang berlaku, meminta Mitra untuk memproses ataupun mendapatkan perizinan lainnya atas nama Mitra pribadi sebagaimana diharuskan berdasarkan peraturan perundang-undangan yang berlaku.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '6. ',
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Mitra menyetujui bahwa SKI dapat:',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.1. Menarik fee sebesar 5% setiap bulan dari total gaji yang diperoleh dari hasil rekomendasi pekerjaan oleh SKI dan untuk melakukan penarikan jumlah yang ditentukan oleh SKI untuk keperluan pembayaran fasilitas akses gaji instant, pembayaran uang penalti atas pelanggaran yang dilakukan oleh Mitra, maupun pembayaran lain sebagaimana berlaku.',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2. Dalam melakukan Kemitraan dengan SKI, Mitra setuju untuk mematuhi kode etik yang ditetapkan oleh SKI, termasuk namun tidak terbatas kepada ketentuan berikut:',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.1 Mitra wajib untuk mematuhi setiap peraturan di setiap tempat kerja sesuai dengan kesepakatan sebelum menerima panggilan kerja tersebut;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.2. Mitra wajib untuk menjaga kebersihan penampilan, berpakaian rapi, bersepatu, menggunakan Atribut;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.3 Mitra dilarang minum minuman keras, mabuk, madat, memakai narkotika ataupun berada dalam keadaan dimana Mitra tidak mempunyai kesadaran penuh;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.4 Mitra dilarang melakukan perbuatan asusila, penganiayan, penghinaan, penipuan atau pengancaman pihak ketiga baik Konsumen, mitra kerja lainnya ataupun pihak ketiga lainnya;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.5. Mitra dilarang membujuk mitra kerja lain melakukan tindakan yang dapat diancam hukuman pidana;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.6. Mitra dilarang, baik dengan sengaja atau karena kelalaiannya, melakukan perbuatan atau membiarkan diri sendiri, konsumen, dan/atau mitra kerja lainnya berada dalam keadaan yang dapat menimbulkan bahaya ke masing-masing pihak;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.7. Mitra dilarang melakukan kegiatan, baik dengan sengaja atau karena kelalaiannya, yang dapat menghasilkan pencemaran nama baik SKI, konsumen SKI, karyawan dan afiliasi dari SKI;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.8. Kecuali diinstruksikan oleh SKI secara tertulis melalui media komunikasi yang ditentukan oleh SKI, Mitra dilarang untuk memungut biaya untuk jasa yang diberikan kepada konsumen berdasarkan kerjasama dengan SKI melalui Perjanjian ini, termasuk namun tidak terbatas kepada dalam memungut jumlah dalam bentuk "tips" kepada konsumen;',
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '6.2.9. Mitra dilarang untuk membongkar atau menyebarluaskan informasi yang diberikan oleh SKI, baik melalui Aplikasi maupun melalui cara lainnya, karyawan dari SKI maupun afiliasi SKI kepada Mitra tanpa persetujuan tertulis dari SKI, sebagaimana berlaku;',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '6.2.10. Mitra dilarang melakukan setiap tindakan yang dilarang oleh hukum ataupun dapat dianggap sebagai pelanggaran hukum yang berlaku;',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.2.11. Mitra dilarang melakukan setiap tindakan yang dapat melanggar ketentuan Perjanjian ini maupun Persyaratan, kebijakan maupun kode etik yang telah diinformasikan kepada Mitra melalui media elektronik (antara lain info Elite yang terdapat pada https://kukerja.id/syaratdanketentuan) dan media komunikasi lainnya yang dapat dipilih oleh SKI maupun afiliasi dari SKI.',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.3. Mitra menyetujui (i) untuk melaporkan kepada SKI dengan segera apabila Mitra melakukan pelanggaran atas Perjanjian ini dan/atau kode etik yang telah ditentukan ataupun mengetahui bahwa adanya pelanggaran Perjanjian ini dan/atau kode etik yang dilakukan oleh mitra SKI lainnya dan (ii) untuk menerima dan menjalankan setiap sanksi yang diberlakukan oleh SKI yang telah diinformasikan oleh SKI maupun afiliasinya kepada Mitra sebelumnya melalui media elektronik dan media komunikasi lainnya yang dipilih oleh SKI.',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.4. Mitra menyetujui bahwa semua risiko maupun kewajiban yang disebabkan oleh kelalaian Mitra, yang termasuk namun tidak terbatas kepada keterlambatan Mitra dalam menyediakan jasa kepada konsumen, kecelakaan, yang mungkin timbul dari maupun sehubungan dengan penyediaan jasa oleh Mitra kepada konsumen merupakan tanggung jawab Mitra.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '   Dengan ini Mitra menyetujui bahwa SKI maupun setiap afiliasinya tidak bertanggung jawab atas setiap kerugian, termasuk kerugian tidak langsung yang meliputi kerugian keuntungan, kehilangan data, cedera pribadi atau kerusakan properti sehubungan dengan, atau diakibatkan oleh penggunaan Aplikasi, maupun penyediaan jasa oleh Mitra kepada Konsumen. Mitra menyetujui bahwa SKI tidak bertanggung jawab atas kerusakan, kewajiban, atau kerugian yang timbul karena penggunaan atau ketergantungan Mitra terhadap Aplikasi atau ketidakmampuan Mitra mengakses atau menggunakan Aplikasi.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'Mitra dengan ini berjanji untuk membebaskan dan memberikan ganti rugi (apabila ada kerugian) kepada SKI, para karyawan SKI maupun afiliasi dari SKI dari semua tuntutan maupun kewajiban yang mungkin timbul dikarenakan kelalaian Mitra sebagaimana dinyatakan dalam pasal ini maupun yang mungkin timbul dikarenakan pelanggaran Mitra atas Persyaratan.',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.5. Mitra menyetujui bahwa apabila Mitra melanggar ketentuan dalam Perjanjian ini maupun kode etik yang ditetapkan oleh SKI maupun dalam hal Mitra tidak memenuhi ketentuan-ketentuan yang ditentukan oleh SKI, SKI mempunyai hak untuk memberikan sanksi kepada Mitra dalam bentuk yang ditentukan oleh SKI, termasuk, namun tidak terbatas kepada, pemberian peringatan tertulis, pembatasan atau penolakan akses Mitra kedalam Akun Mitra dalam Aplikasi, pengakhiran Perjanjian ini maupun memproses tindakan Mitra melalui gugatan perdata (termasuk untuk ganti rugi) maupun pidana, sebagaimana berlaku.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '2. PENGGUNAAN APLIKASI',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '       2.1 Pendaftaran Aplikasi',
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '6.6. Untuk tujuan penggunaan Aplikasi, Mitra harus:',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '6.6.1. Membaca syarat dan ketentuan kerja-sama yang dinyatakan dalam Persyaratan;',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '6.6.2. Memenuhi syarat-syarat yang telah ditentukan sebagaimana di pasal 1 e yang telah di sampaikan diatas;',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '6.6.3. Memberikan persetujuannya atas syarat dan ketentuan yang tercantum di dalam Perjanjian ini dengan cara melakukan tindakan mengklik persetujuan secara elektronik atas Perjanjian ini sebagaimana tertera pada akhir dari Perjanjian ini; dan',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '6.6.4. Mendaftar dan memelihara akun pada Aplikasi KUKERJA sebagai pengguna aktif sebagai ("ELITE").',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '6.6.5. Untuk tujuan mendaftar dan memelihara Akun, Mitra diwajibkan untuk menyerahkan informasi pribadi tertentu kepada SKI, termasuk namun tidak terbatas kepada nama, alamat, nomor telepon, dan informasi mengenai rekening Mitra pada Bank yang direkomendasikan oleh SKI. Mitra menjamin bahwa segala informasi pribadi tertentu yang diberikan kepada SKI adalah benar dan Mitra bertanggung jawab penuh atas kebenaran informasi tersebut. Mitra bertanggung jawab atas semua kegiatan yang terjadi pada Akun yang dipelihara oleh Mitra. Kecuali diizinkan lain oleh SKI secara tertulis, Mitra hanya dapat memiliki dan memelihara satu Akun.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '6.6.6. Mitra setuju untuk memberikan pemberitahuan kepada SKI secara tertulis dalam halnya ada perubahan atas data-data Mitra yang telah diberikan kepada SKI, termasuk namun tidak terbatas kepada nama, alamat, nomor telepon, dan informasi mengenai rekening Mitra pada Bank yang direkomendasikan oleh SKI.',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.6.7. Mitra menyetujui bahwa Mitra dilarang untuk memberian akses kepada pihak ketiga manapun atas Akunnya, termasuk mengalihkan atau memindahkan Akun dan informasi atas Akun yang dimiliki dan dikelola oleh Mitra kepada pihak ketiga siapa pun. Mitra setuju untuk mematuhi semua hukum yang berlaku maupun Persyaratan saat menggunakan Aplikasi, dan Mitra menyetujui bahwa Mitra akan hanya menggunakan Aplikasi untuk tujuan yang dibenarkan oleh hukum (misalnya, tidak membantu perbuatan atau tindakan apapun yang yang dilarang oleh hukum). Mitra tidak boleh, dalam menggunakan Aplikasi, menimbulkan gangguan, ketidaknyamanan, atau kerusakan properti terhadap pihak lain mana pun. Dalam situasi tertentu yang dapat ditentukan oleh SKI, Mitra dapat diminta untuk menunjukkan bukti identitas diri untuk mengakses atau menggunakan Aplikasi, dan Mitra setuju bahwa Mitra dapat ditolak untuk mengakses atau menggunakan Aplikasi jika Mitra menolak untuk memberikan bukti identitas diri.',
                textAlign: TextAlign.justify,
              ),
              Text(
                '6.6.8. Dengan membuat Akun, Mitra setuju bahwa Aplikasi mungkin akan mengirimkan Mitra pesan teks informatif (baik melalui SMS atau aplikasi pengirim pesan) sebagai bagian dari penggunaan Mitra atas Aplikasi.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        const Text(
          '   Dalam hal pelanggaran Persyaratan oleh Mitra, Mitra menyetujui bahwa SKI mempunyai hak untuk mengambil segala macam tindakan yang dianggap perlu oleh SKI untuk menyikapi pelanggaran yang dilakukan oleh Mitra atas Persyaratan atau syarat ketentuan lain yang berlaku maupun pelanggaran yang dicurigai oleh SKI telah dilakukan oleh Mitra (termasuk namun tidak terbatas kepada melakukan penghimpunan fakta terhadap kegiatan Mitra melalui Aplikasi, pemberian surat peringatan, pemutusan akses Mitra atas Aplikasi baik secara permanen maupun sementara, pengakhiran Perjanjian ini maupun memproses tindakan Mitra melalui gugatan perdata maupun pidana, berdasarkan ketentuan perundang-undangan yang berlaku).',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '3. KEBERLAKUAN PERJANJIAN',
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '1. Perjanjian ini berlaku selama 1 (satu) tahun sejak tanggal Mitra mengklik persetujuan secara elektronik pada akhir dari Perjanjian ini. Apabila Perjanjian ini tidak diakhiri oleh salah satu Pihak sesuai dengan syarat dan ketentuan Perjanjian ini, maka periode keberlakuan Perjanjian ini akan diperpanjang secara otomatis setelah berakhirnya periode 1 (satu) tahun yang disebutkan pada awal pasal ini.',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '2. SKI maupun Mitra berhak untuk mengakhiri Perjanjian ini secara sepihak sewaktu-waktu sebelum berakhirnya masa berlaku Perjanjian dengan mengesampingkan ketentuan pasal 1266 Kitab Undang-Undang Hukum Perdata.',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '3. Dalam hal pengakhiran Perjanjian ini, paling lambat 3 (tiga) hari sejak berakhirnya Perjanjian, Mitra wajib melunasi setiap jumlah-jumlah yang masih terhutang kepada SKI maupun pihak ketiga lainnya dan/atau Vendor dan/atau uang penalti atas pelanggaran yang dilakukan oleh Mitra. Pada saat Mitra melunasi setiap jumlah yang terhutang, SKI akan mengembalikan setiap barang atau dokumen lainnya yang telah diserahkan oleh Mitra kepada SKI pada waktu pendaftaran Aplikasi maupun yang mungkin diminta oleh SKI dari waktu ke waktu. SKI mempunyai hak untuk menahan barang atau dokumen lainnya yang telah diserahkan oleh Mitra kepada SKI setelah Perjanjian ini berakhir dalam halnya Mitra mempunyai kewajiban, dalam bentuk apapun, kepada SKI yang belum dipenuhi oleh Mitra.',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '4. Mitra mengetahui dan menyetujui bahwa SKI, mempunyai hak untuk menutup akses mitra kepada Akun yang dimilikinya dalam Aplikasi dalam halnya Perjanjian ini diakhiri.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '4. KETENTUAN LAIN',
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '4.1 Penyelesaian Sengketa',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Mitra dengan ini membebaskan SKI dari segala macam tuntutan, gugatan, atau tindakan hukum lainnya, baik dalam sebuah gugatan perdata maupun setiap gugatan pidana yang dialami oleh Mitra, dalam bentuk apapun terkait dengan jasa yang ditawarkan, disediakan, diselenggarakan atau diselesaikan oleh Mitra melalui Aplikasi melalui kemitraan berdasarkan Perjanjian ini.',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '2. Apabila timbul perselisihan sehubungan dengan penafsiran dan/atau pelaksanaan dari Perjanjian ini maka SKI dan Mitra sepakat untuk menyelesaikan perselisihan dimaksud secara musyawarah. Apabila perselisihan tidak dapat diselesaikan secara musyawarah maka SKI dan Mitra sepakat untuk menyelesaikan perselisihan dimaksud melalui Pengadilan Negeri Kota Pontianak, dengan tidak mengurangi hak SKI untuk mengajukan laporan, gugatan atau tuntutan baik perdata maupun pidana melalui Pengadilan Negeri, Kepolisian dan instansi terkait lainnya dalam wilayah Negara Republik Indonesia.',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '4.2 Penggunaan Informasi Pribadi',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '3. Mitra menyetujui bahwa SKI berhak untuk mengumpulkan dan menggunakan setiap informasi yang diberikan maupun dihasilkan oleh Mitra, informasi tersebut termasuk namun tidak terbatas kepada informasi pribadi yang diberikan oleh Mitra pada saat pendaftaran Aplikasi (yaitu, nama, alamat, keterangan Kartu Tanda Penduduk, nomor telefon, rekening bank Mitra dan lainnya), informasi mengenai lokasi Mitra yang dapat diketahui melalui Aplikasi, informasi mengenai transaksi Mitra melalui Aplikasi, maupun informasi lainnya yang tersedia kepada SKI dari penggunaan Aplikasi oleh Mitra, termasuk namun tidak terbatas kepada memberikan ataupun penyebarluasan informasi tersebut kepada Pihak Ketiga manapun, termasuk pemberian informasi yang diperlukan kepada apparat yang berwenang yang memproses klaim jika terdapat keluhan, perselisihan, atau konflik, yang dapat termasuk kecelakaan, yang melibatkan Mitra dan Konsumen dan informasi atau data tersebut diperlukan untuk menyelesaikan keluhan, perselisihan, atau konflik maupun pemberian informasi untuk keperluan komersil SKI.',
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '4. Mitra dilarang untuk menyebarluaskan atau membagi setiap informasi yang didapatkan olehnya melalui penggunaan Aplikasi, baik informasi mengenai SKI maupun mengenai Konsumen, kepada pihak ketiga manapun tanpa mendapatkan persetujuan tertulis dari SKI sebelumnya.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Text(
          '4.3 Pengalihan',
        ),
        const SizedBox(height: 10),
        const Text(
          'Mitra dilarang mengalihkan Perjanjian ini secara keseluruhan atau sebagian tanpa persetujuan tertulis sebelumnya dari SKI. Mitra memberikan persetujuan kepada SKI untuk dapat mengalihkan Perjanjian ini secara keseluruhan atau sebagian, termasuk namun tidak terbatas kepada: (i) afiliasi; (ii) pihak ketiga yang pada saat pengalihan atau setelahnya menjadi pemilik saham, usaha atau aset SKI atau afiliasinya; atau (iii) penerus dari badan usaha SKI dikarenakan sebab apapun (termasuk namun tidak terbatas kepada penggabungan, pemisahan, dan pengambilalihan).',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
        const Text(
          '4.4 Keterpisahan',
        ),
        const SizedBox(height: 10),
        const Text(
          '   Jika ada ketentuan Perjanjian ini dianggap tidak sah, tidak berlaku atau tidak dapat dilaksanakan secara menyeluruh atau sebagian, maka berdasarkan hukum, ketentuan atau sebagian ketentuan ini harus dianggap sebagai bagian terpisah dari Perjanjian ini, tetapi keabsahan, keberlakuan, dan penerapan ketentuan lainnya dari Perjanjian ini tidak akan terpengaruhi. \n\n   Dalam hal ini, pihak-pihak akan mengganti bagian ketentuan yang sudah tidak berlaku, tidak sah atau tidak dapat diberlakukan dengan ketentuan yang berlaku, sah, dan dapat dilaksanakan dan yang, sedapat mungkin, memiliki efek serupa seperti bagian ketentuan yang tidak sah, tidak berlaku, atau tidak dapat dilaksanakan sebagian, dengan mempertimbangkan isi dan tujuan Perjanjian ini.',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
        const Text(
          '4.5 Keseluruhan dan Keberlanjutan Perjanjian',
        ),
        const SizedBox(height: 10),
        const Text(
          'Perjanjian ini merupakan keseluruhan perjanjian dan pemahaman antara Mitra dengan SKI berkenaan dengan permasalahan pokok serta menukar dan menggantikan semua perjanjian atau kesanggupan terdahulu antara Mitra dengan SKI mengenai permasalahan pokok tersebut. Dalam hal Mitra sudah sebelumnya menyetujui dan/atau menandatangani perjanjian serupa dengan pihak afiliasi dari SKI, maka perjanjian tersebut akan dilanjutkan dan digantikan dengan Perjanjian ini dengan syarat dan ketentuan sebagaimana diatur dalam Perjanjian ini.',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
        const Text(
          '4.6 Persetujuan Para Pihak',
        ),
        const SizedBox(height: 10),
        const Text(
          'Perjanjian ini dibuat dan diberikannya persetujuan oleh SKI dan Mitra dalam keadaan sadar dan tanpa ada paksaan dari pihak manapun juga. Mitra telah membaca, mengerti serta menyetujui setiap dan keseluruhan pasal dalam Perjanjian ini dan akan mematuhi dan melaksanakan setiap pasal dalam Perjanjian dengan penuh tanggung jawab.',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

