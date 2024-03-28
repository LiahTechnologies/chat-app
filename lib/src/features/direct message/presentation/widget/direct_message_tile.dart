
import 'package:flutter/material.dart';

import 'package:njadia/src/features/direct%20message/presentation/widget/chatbubble.dart';


class DirectMessageTile extends StatefulWidget {
  DirectMessageTile(
      {super.key,
      required this.message,
      required this.sender,
       required this.senderId,
      required this.sendbyMe,
      required this.repliedMessage,
      required this.replySender,
      required this.messageId,
      this.time,
      this.recepientId});

  final String message;
  final bool sendbyMe;
  final String sender;
  final String senderId;
  String repliedMessage;
  String replySender;
  final String messageId;

  final String? time;
  final String? recepientId;
  @override
  State<DirectMessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<DirectMessageTile> {
  @override
  Widget build(BuildContext context) {

    return ChatBubble(
      isCurrentUser: widget.sendbyMe,
      text: widget.message,
      sender: widget.sender, 
      repliedMessage: widget.repliedMessage, 
      recepientName: widget.replySender,
      time: widget.time,
    );

  }
}

