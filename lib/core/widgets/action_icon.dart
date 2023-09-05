import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';

class ActionIcon extends StatelessWidget {
  final IconData iconData;
  final String? tooltipMessage;
  final Color? color;
  final Function onTap;
  final String indexWidget;

  const ActionIcon({
    required this.iconData,
    this.tooltipMessage,
    this.color = AppColor.primary,
    required this.onTap,
    required this.indexWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(indexWidget);
      },
      child: Tooltip(
        message: tooltipMessage,
        child: Icon(
          iconData,
          size: 16,
          color: color,
        ),
      ),
    );
  }
}
