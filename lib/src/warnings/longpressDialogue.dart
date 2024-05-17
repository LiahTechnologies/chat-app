import 'package:flutter/material.dart';

import '../utils/naviagtion.dart';

class CustomLongPress extends StatelessWidget {
  CustomLongPress(
      {super.key,
      required this.groupId,
      required this.messageId,
      this.recepientName,
      this.senderTapped,
      this.message});
  final String groupId;
  final String messageId;
  final String? recepientName;
  final String? message;
  final ValueChanged<Map>? senderTapped;

  static const options = ["Reply", "Copy", "Forword", "Pin", "Delete"];
  static const icons = [
    Icons.reply,
    Icons.copy,
    Icons.forward,
    Icons.push_pin,
    Icons.delete
  ];

  // final repleyController = Get.put(ReplyMessageController());
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(alignment: Alignment.center, children: [
      for (int i = 0; i < options.length; i++)
        GestureDetector(
          onTap: () {
            switch (options[i]) {
              case "Delete":
                // DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
                //     .deleteChat(groupId, messageId);
                
                BackScreen(context: context);
               
                break;

              case "Reply":
                print("THE REPLY POPUP WAS CLICKED");
                // repleyController.setReplyMessage(
                //     replymessage: message, replysender: recepientName);

                BackScreen(context: context);
                break;
            }
          },
          child: ListTile(
            leading: Icon(icons[i]),
            title: Text(options[i]),
          ),
        )
    ]);
  }
}
