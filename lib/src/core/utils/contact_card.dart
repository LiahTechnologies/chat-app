import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../common/constants/style/style.dart';


class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact, required this.group});

  final Contact contact;
  final List<Contact> group;
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
              backgroundImage: MemoryImage(contact.avatar!),
              // child: Icon(
              //   Icons.group,
              //   color: primaryWhite,
              //   size: 30,
              // ),
            ),
            group.contains(contact)?
            Positioned(
              bottom: 4,
              right: 4,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: Colors.teal,
                child: Icon(Icons.check,color: primaryWhite,size: 13,)),
            )
            :
            Container()
          ],
        ),
      ),
      title:  Text(
        "${contact.givenName??""} ${contact.familyName??""}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      // subtitle:  Text(
      //   "${contact.}",
      //   style: TextStyle(fontSize: 11),
      // ),
    );
  }
}
