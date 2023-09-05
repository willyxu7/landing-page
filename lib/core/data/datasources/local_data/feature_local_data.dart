import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/data/datasources/feature_data_source.dart';
import 'package:kukerja_web/core/domain/entities/feature_menu.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/screens/freentalent_job_seeker_screen.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/screens/freetalent_employer_screen.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/screens/sultan_recruitment_screen.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/screens/sultan_screen.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/screens/talent_pool_screen.dart';

class FeatureLocalData implements FeatureDataSource {
  @override
  List<FeatureMenu> getFeatureMenus() {
    List<FeatureMenu> featureMenus = [
      FeatureMenu(
          title: "Sultan",
          route: SultanScreen.route,
          icon: FontAwesomeIcons.chessKing),
      FeatureMenu(
          title: "Freetalent Employer",
          route: FreetalentEmployerScreen.route,
          icon: FontAwesomeIcons.users),
      FeatureMenu(
          title: "Freetalent Job Seeker",
          route: FreetalentJobSeekerScreen.route,
          icon: FontAwesomeIcons.addressCard),
      FeatureMenu(
          title: "Talent Pool",
          route: TalentPoolScreen.route,
          icon: FontAwesomeIcons.chessKing),
      FeatureMenu(
          title: "Rekrut Ala Sultan",
          route: SultanRecruitmentScreen.route,
          icon: FontAwesomeIcons.chessKing),
    ];

    return featureMenus;
  }
}
