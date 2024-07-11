import 'package:flutter/material.dart';

import '../common/constants/style/style.dart';


class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.icon, required this.name});

  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return 
       ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 23,
          child: Icon(
            Icons.group,
            color: primaryWhite,
            size: 30,
          ),
        ),
        title: Text(
          "$name",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "$icon",
          style: TextStyle(fontSize: 11),
        ),
      );
  }
}
