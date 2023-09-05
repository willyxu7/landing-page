import 'package:kukerja_web/features/kukerja/landing_page/domain/entities/our_feature.dart';

class WhyUsLocalData {
  List<OurFeature> getOurFeatures() {
    List<OurFeature> ourFeatures = [
      OurFeature(
          fileLocation: 'assets/images/time.png',
          title: '1. Hemat Waktu',
          description:
              'Kalau rekrutmen biasa kamu memerlukan waktu 1-7 hari, Kukerja siap membantumu dalam hitungan jam!'),
      OurFeature(
          fileLocation: 'assets/images/access.png',
          title: '2. Akses Pekerja Berkualitas',
          description:
              'Rekrut langsung pekerja yang telah kami screening, berpengalaman dan terlatih'),
      OurFeature(
          fileLocation: 'assets/images/guaranteed.png',
          title: '3. Garansi',
          description:
              'Kami berikan garansi rekrut kembali apabila pekerja kami berhenti dalam kurun waktu 14 hari'),
      OurFeature(
          fileLocation: 'assets/images/trusted.png',
          title: '4. Pekerja pilihan',
          description:
              'Bergabung sebagai Elite, untuk dapatkan panggilan kerja tanpa melamar dan interview, buktikan kalau kamu siap kerja!'),
      OurFeature(
          fileLocation: 'assets/images/offer.png',
          title: '5. Tawarkan diri',
          description:
              'Kini, kamu bukan cuma bisa melamar, tunjukkan kalau kamu adalah pilihan utama sebagai calon pekerja'),
      OurFeature(
          fileLocation: 'assets/images/connected.png',
          title: '6. Terhubung langsung',
          description:
              'Di Kukerja, kami menghubungkan kamu langsung dengan pihak pemberi kerja, selamat tinggal dunia tipu-tipu!')
    ];

    return ourFeatures;
  }
}
