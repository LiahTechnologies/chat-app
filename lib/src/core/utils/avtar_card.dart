import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/chat_model_list_data.dart';
import 'package:njadia/src/core/model/chatmodel.dart';

import '../common/constants/style/style.dart';

class AvtarCard extends StatelessWidget {
  const AvtarCard({super.key, required this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.check,
                      color: primaryWhite,
                      size: 13,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "${contact.givenName??""}   ${contact.familyName??""}",
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          )
        ]
      ),
    );
  }
}
