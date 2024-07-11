import 'package:flutter/material.dart';

import '../common/constants/style/style.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({super.key, required this.items});
  final List<PopupMenuItem> items;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).bottomAppBarTheme.shadowColor,
        onSelected: (value) {
          print("values selected is $value");
        },
        iconColor: primaryWhite,
        itemBuilder: (BuildContext context) {
          return items;

          /*[
            PopupMenuItem(
              child: Text("New Group"),
              value: "New Group",
            ),
            PopupMenuItem(
              child: Text("New Broadcast"),
              value: "New Broadcast",
            ),
            PopupMenuItem(
              child: Text("Whatsap web"),
              value: "Whatsapp web",
            ),
            PopupMenuItem(
              child: Text("Start Message"),
              value: "Start Message",
            ),
            PopupMenuItem(
              child: Text("Settings"),
              value: "Settings",
            ),
          ];
         */ 
        });
  }
}
