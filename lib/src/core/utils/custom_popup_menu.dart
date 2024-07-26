import 'package:flutter/material.dart';

import '../common/constants/style/style.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({super.key, required this.items, required this.onSelected});
  final List<PopupMenuItem> items;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).bottomAppBarTheme.shadowColor,
        onSelected: (value) {
          onSelected(value);
        },
        iconColor: primaryWhite,
        itemBuilder: (BuildContext context) {
          return items;
        });
  }
}
