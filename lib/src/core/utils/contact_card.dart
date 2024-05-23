import 'package:flutter/material.dart';
import 'package:njadia/src/core/model/chat_model.dart';

import '../chats functionality/core/style.dart';


class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child:
         Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[200],
              radius: 23,
              child: Icon(
                Icons.group,
                color: primaryWhite,
                size: 30,
              ),
            ),
            contact.isSelected?
            Positioned(
              bottom: 4,
              right: 4,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: Colors.teal,
                child: Icon(Icons.check,color: primaryWhite,size: 13,)),
            ):Container()
          ],
        ),
      ),
      title:  Text(
        "${contact.name}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle:  Text(
        "${contact.status}",
        style: TextStyle(fontSize: 11),
      ),
    );
  }
}
