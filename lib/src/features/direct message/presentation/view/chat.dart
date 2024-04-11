
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/features/direct%20message/presentation/controller/direct_message_controller.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';
import 'package:swipe_to/swipe_to.dart';

import '../widget/direct_message_tile.dart';


class DirectMessageChat extends StatefulWidget {
  final String profileImg;
  String? senderName;
  final String senderId;
  final String chatId;
  bool canCreate;

  // final String ;
  DirectMessageChat({
    super.key,
    required this.profileImg,
    this.senderName,
    required this.senderId,
    required this.chatId,
    this.canCreate=false
  });

  @override
  State<DirectMessageChat> createState() => _DirectMessageChatState();
}

class _DirectMessageChatState extends State<DirectMessageChat> {
  // Stream<QuerySnapshot>? chat;
  String admin = '';
  // User? user;
  String chatId = '';


  @override
  void initState() {
    getChatandAdmin();
    if(widget.canCreate)
    createChat();
    super.initState();
  }

  createChat() async{
  //  await DatabaseServices()
  //       .createChat(
  //           sendersId: FirebaseAuth.instance.currentUser!.uid,
  //           recipientId: widget.senderId)
  //       .then((value) {
  //     setState(() {
  //       chatId = value;
  //     });
  //   });
  }

  void getChatandAdmin() {
    // DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
    //     .getChatMessages(widget.chatId)
    //     .then((val) {
    //   setState(() {
    //     chat = val;
    //     print("THIS IS THE LIST OF CHATS $chat");
    //   });
    // });

    // DatabaseServices().getGroupAdmin(widget.groupId).then((value) {
    //   setState(() {
    //     admin = value;
    //   });
    // });
  }

  //final authService = AuthService();
  final TextEditingController messageController = TextEditingController();

  final controller = DirectMessageController();
  final replyController = DirectReplyMessageController();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading:const CustomBackArrow(),
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(widget.profileImg),
              ),
              Text(
                widget.senderName!.toUpperCase().toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.videocam,
                  color: Theme.of(context).iconTheme.color,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.phone,
                  color: Theme.of(context).iconTheme.color,
                )),
            PopupMenuButton(
                onSelected: (value) {},
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).iconTheme.color,
                ),
                itemBuilder: (context) {
                  return [
                    // PopupMenuItem(
                    //   child: Text("send money"),
                    //   value: "send money",
                    // ),
                    // PopupMenuItem(
                    //   child: Text("send money"),
                    //   value: "send money",
                    // )
                  ];
                }),
          ],
        ),
        body: Column(children: [
          // chatMessages(),
          Text(""),
          Container(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Positioned(child: _buildMessageComposer()),
                Positioned(bottom: 10, right: 14, child: sendButton())
              ],
            ),
          )

          
        ]));
  }

  sendButton() {
    return GestureDetector(
      onTap: sendMessage,
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


  sendMessage() {
    if (messageController.text.isNotEmpty) {
    
      messageController.clear();

      setState(() {
        messageController.clear();
      });
    }
  }



  chatMessages() {
    return StreamBuilder(
        stream: chat,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      key: PageStorageKey<String>('directchat'),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        //  this is is adda the current user to the view list of this message
                        // controller.updateMessageViewed(messageId: snapshot.data!.docs[index].id,chatId: snapshot.data!.),
                        return SwipeTo(
                          onRightSwipe: (v) {
                            // replyController.setReplyMessage(
                            //     replymessage: snapshot.data!.docs[index]
                            //         ['message'],
                            //     replysender: snapshot.data!.docs[index]
                            //         ['sender']);
                          },
                          child: DirectMessageTile(
                            message: snapshot.data!.docs[index]['message'],
                            sendbyMe: FirebaseAuth.instance.currentUser!.uid ==
                                snapshot.data!.docs[index]['senderId'],
                            repliedMessage: snapshot.data!.docs[index]
                                ['replyMessage']??"",
                            replySender: snapshot.data!.docs[index]
                                ['replySender'],
                            time: snapshot.data!.docs[index]['time'],
                            messageId: snapshot.data!.docs[index]['messageId'],
                            senderId: snapshot.data!.docs[index]['senderId'],
                            sender: snapshot.data!.docs[index]['sender'],
                          ),
                        );
                      }),
                )
              : Container();
        });
  }

  Widget _buildMessageComposer() {
    return Container(
        alignment: Alignment.bottomLeft,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (showSwipeDialog)
                    if (replyController.showReplyDialog)
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
                                              "${replyController.replySender}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              "${replyController.replyMessage}",
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
                              replyController.showReplyDialog ? 0 : 5.h),
                      // height: 50.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.only(
                            topLeft: replyController.showReplyDialog
                                ? Radius.zero
                                : Radius.circular(20),
                            topRight: replyController.showReplyDialog
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
              )
            ));
  }

  clearReplyMessageText() {
    replyController.showReplyDialog = false;
    replyController.replyMessage = "";
    replyController.replySender = "";
  }
}
