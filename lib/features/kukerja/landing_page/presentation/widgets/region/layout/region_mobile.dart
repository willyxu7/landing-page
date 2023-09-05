import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/region/layout/region_content.dart';
import 'package:flutter/material.dart';

class RegionMobile extends StatelessWidget {
  const RegionMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image.asset(
        //   'images/globe.png',
        // ),
        Wrap(
          children: const [
            RegionContent(title: 'DKI Jakarta', contents: [
              'Jakarta Pusat',
              'Jakarta Utara',
              'Jakarta Selatan',
              'Jakarta Timur',
              'Jakarta Barat'
            ]),
            RegionContent(
                title: 'Jawa Barat',
                contents: ['Bandung', 'Bekasi', 'Depok', 'Bogor']),
            RegionContent(title: 'Jawa Tengah', contents: [
              'Semarang',
              'Surakarta',
              'Purwokerto',
            ]),
            RegionContent(title: 'Jawa Timur', contents: [
              'Surabaya',
            ]),
            RegionContent(title: 'Banten', contents: [
              'Tangerang',
            ]),
            RegionContent(
                title: 'Kalimantan Barat',
                contents: ['Pontianak', 'Singkawang']),
            RegionContent(
                title: 'Kalimantan Timur',
                contents: ['Samarinda', 'Balikpapan']),
            RegionContent(title: 'Sumatera Utara', contents: [
              'Medan',
            ]),
            RegionContent(title: 'Lampung', contents: [
              'Bandar Lampung',
            ]),
          ],
        )
      ],
    );
  }
}
