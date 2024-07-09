import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-bloc.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-event.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../payment/presentation/view/select_group_member.dart';

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

  void getChatandAdmin() {}

  final TextEditingController messageController = TextEditingController();
  // final repleyController = Get.put(ReplyMessageController());

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
          onPressed: () => BackScreen(context: context),
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
                    NextScreen(context: context, page: SelectGroupMember());
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
          chatMessages(context),
          Stack(
            children: [
              Positioned(child: _buildMessageComposer()),
              Positioned(bottom: 10, right: 14, child: sendButton(context))
            ],
          )
        ],
      ),
    );
  }

  sendButton(BuildContext context) {
    return GestureDetector(
      onTap: ()=>context.read<GroupChatBloc>().add(OnSentGroupMessage(message: MessageEntity(messageId: "messageId", messageReceiver: "messageReceiver", messageSender: "messageSender", replyMessage: "replyMessage", replySender: "replySender", dateTime: "9:00am", message: messageController.text, chatId: ''), groupId: "groupId")),
      child: Container(
          alignment: Alignment.bottomRight,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).iconTheme.color,
              borderRadius: BorderRadius.circular(30)),
          child: const Center(child: Icon(Icons.send, color: Colors.white))),
    );
  }




  chatMessages(BuildContext context) {
    return StreamBuilder(
        stream: context.read<GroupChatBloc>().stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      key: PageStorageKey<String>('directchat'),
                      shrinkWrap: true,
                      itemCount: 2,
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
                          child: Text(""),


                          // child: DirectMessageTile(
                          //   message: "We don't have a class today",
                          //   sendbyMe: true,
                          //   repliedMessage: "replied message",
                          //   replySender: "John",
                          //   time: DateTime.now().toString(),
                          //   messageId: "jdso740843n3io390783",
                          //   senderId: "sdjloewiu09800213djsd",
                          //   sender: "Betrand",
                          // ),
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


                    // if (showReplyDialog)
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
                                    decoration:  BoxDecoration(
                                        color:Theme.of(context).iconTheme.color,
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
                                              "",
                                              // "${repleyController.replySender.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              "",
                                              // "${repleyController.replyMessage.value}",
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
                          // vertical:
                          //     repleyController.showReplyDialog.value ? 0 : 5.h
                          ),
                      // height: 50.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          // borderRadius: BorderRadius.only(

                          //   topLeft: repleyController.showReplyDialog.value
                          //       ? Radius.zero
                          //       : Radius.circular(20),
                          //   topRight: repleyController.showReplyDialog.value
                          //       ? Radius.zero
                          //       : Radius.circular(20),

                          //   bottomLeft: Radius.circular(20),
                          //   bottomRight: Radius.circular(20),
                          // )
                          ),
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
    // repleyController.showReplyDialog.value = false;
    // repleyController.replyMessage.value = "";
    // repleyController.replySender.value = "";
  }
}
