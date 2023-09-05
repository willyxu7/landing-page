import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/experience_description.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/experience_year_description.dart';

import '../../../../../../core/widgets/action_icon.dart';

class ExperienceInformation extends StatelessWidget {
  final String indexWidget, startYear, endYear, profession, company;
  final Function onEdit;
  final Function onDelete;

  const ExperienceInformation(
      {required this.indexWidget,
      required this.startYear,
      required this.endYear,
      required this.profession,
      required this.company,
      required this.onEdit,
      required this.onDelete,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: ExperienceYearDescription(
                title: "Tahun",
                start: startYear,
                end: endYear,
              )),
          Expanded(
              flex: 3,
              child: ExperienceDescription(
                title: "Posisi",
                content: profession,
              )),
          Expanded(
              flex: 3,
              child: ExperienceDescription(
                title: "Company",
                content: company,
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionIcon(
                  tooltipMessage: "Edit",
                  iconData: FontAwesomeIcons.pen,
                  color: Colors.blue,
                  onTap: (index) {
                    onEdit(index);
                  },
                  indexWidget: indexWidget),
              const SizedBox(width: 10),
              ActionIcon(
                  tooltipMessage: "Delete",
                  iconData: FontAwesomeIcons.trash,
                  onTap: (index) {
                    onDelete(index);
                  },
                  indexWidget: indexWidget)
            ],
          )
        ],
      ),
    );
  }
}
