import 'package:flutter/material.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/core/utils/reply_card.dart';
import 'package:njadia/src/core/utils/user_card.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key, required this.messageEntity});

  final MessageEntity messageEntity;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return widget.messageEntity.messageSender=="me"?UserCard(messageEntity: widget.messageEntity,):ReplyCard(messageEntity: widget.messageEntity,);
  }
}
