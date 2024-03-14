
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/helper_function.dart';
import '../../../../common/randomId.dart';
// import '../../../../common/services/firebase_messaging.dart';
import '../controller/create_group_service.dart';
import '../widgets/messageTitle.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Stream<QuerySnapshot>? chat;
  String admin = '';

  @override
  void dispose() {
    clearReplyMessageText();
  }

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  void getChatandAdmin() {
    // DatabaseServices().getChats(widget.groupId).then((val) {
    //   setState(() {
    //     // chat = val;
    //   });
    // });

    // DatabaseServices().getGroupAdmin(widget.groupId).then((value) {
    //   setState(() {
    //     admin = value;
    //   });
    // });
  }

  final TextEditingController messageController = TextEditingController();
  final repleyController = Get.put(ReplyMessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 11,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.groupName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case "send money":
                    Get.toNamed(AppRoutes.SELECT_GROUP_MEMBER_PAGE);
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).iconTheme.color,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("send money"),
                    value: "send money",
                  )
                ];
              }),
        ],
      ),
      body: Column(
        children: [
          // chatMessages(),
          Stack(
            children: [
              Positioned(child: _buildMessageComposer()),
              Positioned(bottom: 10, right: 14, child: sendButton())
            ],
          )
        ],
      ),
    );
  }


  sendButton() {
    return GestureDetector(
      // onTap: sendMessage,
      child: Container(
          alignment: Alignment.bottomRight,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: AppColor.purpleColor,
              borderRadius: BorderRadius.circular(30)),
          child: Center(child: Icon(Icons.send, color: Colors.white))),
    );
  }

/*

  chatMessages() {
    return StreamBuilder(
        // stream: chat,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      key: PageStorageKey<String>('groupchat'),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {

                        return SwipeTo(
                          onRightSwipe: (v) {
                            repleyController.setReplyMessage(
                                replymessage: snapshot.data!.docs[index]
                                    ['message'],
                                replysender: snapshot.data!.docs[index]
                                    ['sender']);

                          },

                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: MessageTile(
                              messageId: snapshot.data!.docs[index]['messageId'] ,
                              message: snapshot.data!.docs[index]['message'],  
                              isCurrentUser: FirebaseAuth.instance.currentUser!.uid ==
                                  snapshot.data!.docs[index]['senderId'],
                              replyMessage: snapshot.data!.docs[index]
                                  ['replyMessage'],
                              replySender: snapshot.data!.docs[index]
                                  ['replySender'],
                              groupId: widget.groupId,
                              senderNumber: snapshot.data!.docs[index]
                                  ['senderNumber'],
                              time: snapshot.data!.docs[index]['time'],
                              senderId: snapshot.data!.docs[index]['senderId'],
                              sender:snapshot.data!.docs[index]['sender'] ,
                            ),
                          ),
                        );

                        // return Text("$index  this is the position of the text");
                      }),
                )
              : Container();
        });
  }
  */


/*
// Send message
  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text.trim(),
        "messageId":sha1RandomString(),
        "sender": FirebaseAuth.instance.currentUser!.displayName,
        "time": DateFormat('kk:mm:a').format(DateTime.now()).toString(),
        "isReply": repleyController.showReplyDialog.value,
        "replyMessage": repleyController.replyMessage.value,
        "replySender": repleyController.replySender.value,
        "senderNumber": FirebaseAuth.instance.currentUser!.phoneNumber,
        "senderId": FirebaseAuth.instance.currentUser!.uid
      };

      DatabaseServices()
          .sendMessage(groupId: widget.groupId, chatMessages: chatMessageMap);
      setState(() {
        messageController.clear();
      });
      setState(() {
        repleyController.showReplyDialog.value = false;
      });
    }
  }

*/


  Widget _buildMessageComposer() {
    return Container(
        alignment: Alignment.bottomLeft,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            child: Obx(() {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (showSwipeDialog)
                    if (repleyController.showReplyDialog.value)
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 9.w),
                          height: 80.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .cardTheme
                                  .color!
                                  .withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          width: 280.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 3.h,
                                    decoration: const BoxDecoration(
                                        color: AppColor.cardColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 9.0),
                                            child: Text(
                                              "${repleyController.replySender.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              "${repleyController.replyMessage.value}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: clearReplyMessageText),
                              ),
                            ],
                          )),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical:
                              repleyController.showReplyDialog.value ? 0 : 5.h),
                      // height: 50.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.only(
                            topLeft: repleyController.showReplyDialog.value
                                ? Radius.zero
                                : Radius.circular(20),
                            topRight: repleyController.showReplyDialog.value
                                ? Radius.zero
                                : Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                minLines: 1,
                                maxLines: 6,
                                controller: messageController,
                                style: Theme.of(context).textTheme.displayLarge,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  hintText: "Send a Message",
                                  hintStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  border: InputBorder.none,

                                  // suffixIcon: IconButton(icon:const  Icon(Icons.link,),onPressed: (){},)
                                )),
                          ),
                          RotatedBox(
                              quarterTurns: 2,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.attachment_outlined,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })));
  }

  clearReplyMessageText() {
    repleyController.showReplyDialog.value = false;
    repleyController.replyMessage.value = "";
    repleyController.replySender.value = "";
  }
}
