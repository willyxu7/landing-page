import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/education_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/education_non_formal_dialog.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/widgets/items/experience_dialog.dart';



class JobSeekerUtil {
  static Future<void> openEducationFormalDialog(BuildContext context) =>
      showDialog(
          context: context,
          useRootNavigator: false,
          builder: (BuildContext buildContext) {
            return EducationFormalDialog(
              buildContext: buildContext,
            );
          });

  static Future<void> openEducationNonFormalDialog(BuildContext context) =>
      showDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) {
            return const EducationNonFormalDialog();
          });

  static Future<void> openExperienceDialog(BuildContext context) => showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return const ExperienceDialog();
      });
}
