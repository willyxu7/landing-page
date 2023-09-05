import 'package:kukerja_web/core/data/datasources/religion_data_source.dart';
import 'package:kukerja_web/core/domain/repositories/religion_repository.dart';

class ReligionRepositoryImpl extends ReligionRepository {

  late ReligionDataSource _religionDataSource;

  ReligionRepositoryImpl(ReligionDataSource religionDataSource) {
    _religionDataSource = religionDataSource;
  }

  @override
  List<String> getReligions() {
    return _religionDataSource.getReligions();
  }

}