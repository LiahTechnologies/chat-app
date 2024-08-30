import 'package:flutter/material.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/core/utils/user_card.dart';

import '../core/utils/reply-message-card.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messageEntity, required this.uid, required this.previousMessageSenderId});

  final MessageEntity messageEntity;
  final String uid;
  final String previousMessageSenderId;

// late String uid;
  @override
  Widget build(BuildContext context) {
    print("Messagelist Widget $messageEntity");
  //   BubbleSpecialOne(
  //   text: 'Hi, How are you? ',
  //   isSender: false,
  //   color: Colors.purple.shade100,
  //   textStyle: TextStyle(
  //     fontSize: 20,
  //     color: Colors.purple,
  //     fontStyle: FontStyle.italic,
  //     fontWeight: FontWeight.bold,
  //   ),
  // ),
    return messageEntity.senderId==uid?UserCard(messageEntity: messageEntity, previousMessageSenderId: previousMessageSenderId,):ReplyMessageCard(messageEntity: messageEntity,previousMessageSenderId: previousMessageSenderId,);
  }
}
