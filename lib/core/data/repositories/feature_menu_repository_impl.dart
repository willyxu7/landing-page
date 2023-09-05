import 'package:kukerja_web/core/data/datasources/feature_data_source.dart';
import 'package:kukerja_web/core/domain/entities/feature_menu.dart';
import 'package:kukerja_web/core/domain/repositories/feature_menu_repository.dart';

class FeatureMenuRepositoryImpl implements FeatureMenuRepository {

  late FeatureDataSource _featureDataSource;

  FeatureMenuRepositoryImpl(FeatureDataSource featureDataSource) {
    _featureDataSource = featureDataSource;
  }

  @override
  List<FeatureMenu> getFeatureMenus() {
    return _featureDataSource.getFeatureMenus();
  }

}