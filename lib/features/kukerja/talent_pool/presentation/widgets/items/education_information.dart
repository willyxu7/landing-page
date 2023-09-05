import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kukerja_web/core/widgets/action_icon.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_description.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/widgets/items/education_year_description.dart';

class EducationInformation extends StatelessWidget {
  final String indexWidget;
  final String startYear;
  final String? endYear;
  final String educationPlace;
  final Function onEdit;
  final Function onDelete;

  const EducationInformation({
    required this.indexWidget,
    required this.startYear,
    required this.endYear,
    required this.educationPlace,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: EducationYearDescription(
                title: "Tahun",
                start: startYear,
                end: endYear ?? "Sekarang",
              )),
          Expanded(
              flex: 3,
              child: EducationDescription(
                title: "Tempat Pendidikan",
                content: educationPlace,
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
