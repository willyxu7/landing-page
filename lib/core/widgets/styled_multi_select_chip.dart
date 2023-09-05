import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class StyledMultiSelectChip<T> extends StatelessWidget {
  final int? maxSelectable;
  final List<MultiSelectCard<T>> items;
  final Function(List<T> selectedItems, T selectedItem) onChange;

  const StyledMultiSelectChip({
    this.maxSelectable,
    required this.items,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectContainer<T>(
        maxSelectableCount: maxSelectable,
        items: items,

        prefix: MultiSelectPrefix(
            selectedPrefix: const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                FontAwesomeIcons.check,
                color: Colors.white,
                size: 14,
              ),
            )),
        itemsDecoration: MultiSelectDecorations(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondary),
              borderRadius: BorderRadius.circular(20)),
          selectedDecoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppColor.secondary, Colors.lightGreen]),
              border: Border.all(color: AppColor.secondary),
              borderRadius: BorderRadius.circular(5)),
          disabledDecoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey[500]!),
              borderRadius: BorderRadius.circular(10)),
        ),
        onChange: (allSelectedItems, selectedItem) {
          onChange(allSelectedItems, selectedItem);
        });
  }
}
