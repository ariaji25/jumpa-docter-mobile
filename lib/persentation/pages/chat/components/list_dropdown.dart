import 'package:flutter/material.dart';

import '../../../common/const.dart';
import '../../../common/theme/theme.dart';

class ListDropdown extends StatefulWidget {
  final String title;
  final Map<String, Widget> items;
  final Function(String) onTap;

  const ListDropdown(
      {Key? key, required this.title, required this.items, required this.onTap})
      : super(key: key);

  @override
  State<ListDropdown> createState() => _ListDropdownState();
}

class _ListDropdownState extends State<ListDropdown> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          focusColor: Colors.black,
          style: const TextStyle(color: Themes.grey700Color, fontSize: 14),
          alignment: Alignment.bottomCenter,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Themes.primaryColorDarkColor,
          ),
          underline: const SizedBox(),
          hint: Container(
            margin: const EdgeInsets.only(bottom: 15), //and here
            child: Text(
              widget.title,
              style: kBodyText.copyWith(
                  fontSize: 14, color: Themes.primaryColorDarkColor),
            ),
          ),
          items: getItems(),
          onChanged: (dynamic value) {
            setState(() {
              this.value = value;
            });
            widget.onTap(value.toString());
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    List<DropdownMenuItem> items = widget.items.entries
        .map((entry) => DropdownMenuItem(child: entry.value, value: entry.key))
        .toList();
    return items;
  }
}
