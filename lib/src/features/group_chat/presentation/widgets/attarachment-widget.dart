import 'package:flutter/material.dart';

import '../../../../core/common/constants/style/style.dart';

class Attarachment extends StatelessWidget {
  const Attarachment({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.insert_drive_file,
                      text: "Document",
                      color: Colors.indigo),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.camera_alt,
                      text: "Camera",
                      color: Colors.pink),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.insert_photo,
                      text: "Photo",
                      color: Colors.purple),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.headset, text: "Audio", color: Colors.orange),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.location_pin,
                      text: "Location",
                      color: Colors.teal),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.person, text: "Contact", color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget iconCreation(
      {required IconData icon, required String text, required Color color}) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: primaryWhite,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("$text")
        ],
      ),
    );
  }
}