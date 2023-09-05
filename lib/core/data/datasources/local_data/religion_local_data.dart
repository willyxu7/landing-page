import 'package:kukerja_web/core/data/datasources/religion_data_source.dart';

class ReligionLocalData extends ReligionDataSource {
  @override
  List<String> getReligions() {
    List<String> religions = [
      "Budha",
      "Hindu",
      "Islam",
      "Katolik",
      "Protestan",
      "Konghucu",
    ];

    return religions;
  }
}
