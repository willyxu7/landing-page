import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class SimpleOutlinedDropdownSearch<T> extends StatefulWidget {
  final List<T>? items;
  final Function onChanged;
  final DropdownSearchOnFind<T>? onFind;
  final DropdownSearchItemAsString<T>? itemAsString;
  final DropdownSearchBuilder<T>? dropdownBuilder;
  final String hintText;
  final bool showSelectedItems;
  final bool optional, showSearchBox;
  final EdgeInsets margin;
  final T? selectedItem;

  const SimpleOutlinedDropdownSearch(
      {required this.items,
      required this.onChanged,
      this.onFind,
      this.itemAsString,
      this.dropdownBuilder,
      this.hintText = '',
      this.showSelectedItems = false,
      this.optional = false,
      this.showSearchBox = true,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.selectedItem,
      Key? key})
      : super(key: key);

  const SimpleOutlinedDropdownSearch.withApi(
      {required this.onChanged,
      required this.hintText,
      required this.itemAsString,
      this.dropdownBuilder,
      required this.onFind,
      this.items,
      this.showSelectedItems = false,
      this.optional = false,
        this.showSearchBox = true,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.selectedItem,
      Key? key})
      : super(key: key);

  @override
  _SimpleOutlinedDropdownSearchState<T> createState() =>
      _SimpleOutlinedDropdownSearchState<T>();
}

class _SimpleOutlinedDropdownSearchState<T>
    extends State<SimpleOutlinedDropdownSearch<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: widget.margin,
      child: DropdownSearch<T>(
          dropdownBuilder: widget.dropdownBuilder,
          asyncItems: widget.onFind,
          popupProps: PopupProps.menu(
            showSearchBox: widget.showSearchBox,
            showSelectedItems: widget.showSelectedItems,
            searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.secondary, width: 2)))),
          ),
          itemAsString: widget.itemAsString,
          items: widget.items!,
          selectedItem: widget.selectedItem,
          onChanged: (value) {
            widget.onChanged(value);
          },
          validator: (value) {
            if (!widget.optional) {
              return (value == null ||  value.toString().isEmpty) ? 'Mohon kolom ini diisi' : null;
            }
            return null;
          },
          dropdownButtonProps: const IconButtonProps(
              icon: Icon(
            FontAwesomeIcons.angleDown,
            color: Colors.grey,
          )),
          dropdownSearchDecoration: InputDecoration(
              hintText: widget.hintText,
              focusColor: AppColor.secondary,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.secondary, width: 2)))),
    );
  }
}
