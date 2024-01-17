import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/common/constants/style/color.dart';

import '../../../../common/helper_function.dart';
import '../../../../common/services/firebase_messaging.dart';
import '../../../direct message/presentation/view/chat.dart';
import '../view/chatpage.dart';

class GroupTile extends StatefulWidget {
  final String? userName;
  final String? groupid;
  final String groupName;
  final bool? isDirectMessage;
  final String? recepientId;

  const GroupTile(
      {super.key,
      required this.groupName,
      this.userName,
      this.groupid,
      this.isDirectMessage = false,
      this.recepientId = ""});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  Stream<QuerySnapshot>? lastChat;

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  void getChatandAdmin() {
    DatabaseServices().getChats(widget.groupid!).then((val) {
      setState(() {
        lastChat = val;
      });
    });

    getLastMessage();
  }

  Widget getLastMessage() {
    return StreamBuilder(
        stream: lastChat,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.data!.docs.length > 0
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        print(
                            "The last message and sender is ${snapshot.data!.docs[snapshot.data!.docs.length - 1]['sender']}  ${snapshot.data!.docs[snapshot.data!.docs.length - 1]['message']}");

                        return Text(
                          "${snapshot.data!.docs[snapshot.data!.docs.length - 1]['sender']}  ${snapshot.data!.docs[snapshot.data!.docs.length - 1]['message']}",
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                )
              : Text("");
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatPage(
              groupId: widget.groupid!,
              groupName: widget.groupName,
              userName: widget.groupName),
          transition: Transition.zoom,
        );
        // : Get.to(
        //     DirectMessageChat(
        //       groupId: widget.groupid!,
        //       senderName: widget.userName!,
        //       senderId: widget.recepientId!,
        //       profileImg: '',
        //     ),
        //     transition: Transition.zoom,
        //   );
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
                  widget.groupName.substring(0, 1).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                widget.groupName,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              subtitle: getLastMessage(),
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
