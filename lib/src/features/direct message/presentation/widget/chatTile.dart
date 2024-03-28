import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import '../../../direct message/presentation/view/chat.dart';

class ChatTile extends StatefulWidget {
  final String? userName;
  final String? userId;
  final bool? isDirectMessage;
  final Widget? lastMessage;
  final String? recepientId;
  final String? groupId;
  const ChatTile(
      {super.key,
      this.userName,
      this.isDirectMessage = false,
      this.recepientId = "",
      this.lastMessage,
      this.groupId,
      this.userId});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("REACHING THIS LEVEL ${widget.groupId}");
        print("REACHING THIS LEVEL ${widget.groupId}");
        NextScreen(
          context: context,
          page: DirectMessageChat(
            chatId: widget.groupId!,
            senderName: widget.userName!,
            senderId: widget.recepientId!,
            profileImg: '',
          ),
        );
      },
      child: Container(
          height: 50.h,
          width: 500.w,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          // padding: const EdgeInsets.only(bottom: 16),

          child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pinkAccent,
                child: Text(
                  "${widget.userName!.substring(0, 1).toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                "${widget.userName!}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              subtitle: widget.lastMessage,
              trailing: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.greenColor),
                child: Center(
                    child: Text(
                  "22",
                  style: TextStyle(color: AppColor.whiteColor),
                )),
              ))),
    );
  }
}
