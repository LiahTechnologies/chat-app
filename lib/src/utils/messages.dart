import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/core/utils/reply_card.dart';
import 'package:njadia/src/core/utils/user_card.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messageEntity, required this.uid});

  final MessageEntity messageEntity;
  final String uid;

// late String uid;
  @override
  Widget build(BuildContext context) {
    print("Messagelist Widget $messageEntity");
    return messageEntity.senderId==uid?UserCard(messageEntity: messageEntity,):ReplyCard(messageEntity: messageEntity,);
  }
}
