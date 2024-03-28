
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'chatbubble.dart';

class MessageTile extends StatefulWidget {
  MessageTile(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.sender,
      required this.replyMessage,
      required this.replySender,
      required this.messageId,
      required this.groupId,
      this.senderNumber,
      this.time,
      this.senderId});

  final String message;
  final bool isCurrentUser;
  final String sender;
  String replyMessage;
  String replySender;
  final String messageId;
  final String groupId;
  final String? senderNumber;
  final String? time;
  final String? senderId;
  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.w),
      child: ChatBubble(message: widget.message, 
      isCurrentUser: widget.isCurrentUser,
       messageId: widget.messageId,
      repliedMessage: widget.replyMessage,
      recepientName: widget.replySender,
      senderId: widget.senderId, 
      sender: widget.sender,
      time: widget.time,
      chatId: widget.groupId,
     
      ),
    );



/*
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sendbyMe ? 24 : 24,DirectMessageChat
          right: widget.sendbyMe ? 24 : 24),
      alignment: widget.sendbyMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: GestureDetector(
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => SeeChatProfile(
                          profileImag: AppImages.PERSON,
                          chat: () async {
                            Get.to(
                              DirectMessageChat(
                              profileImg: AppImages.PERSON,
                              userName: widget.recepientName,
                              recepientId: widget.recepientId!,
                              groupId: widget.groupId,           
                            ));
                          },
                          videoCall: () {
                            Get.back();
                            Get.toNamed(AppRoutes.HOMEpAGE);
                          },
                        ));
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(AppImages.PERSON),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Align(
                          alignment: Alignment.topLeft,
                          child: CustomLongPress(
                            groupId: widget.groupId,
                            messageId: widget.messageId,
                            message: widget.message,
                            recepientName: widget.recepientName,
                            senderTapped: (value) {
                              setState(() {
                                widget.recepientName = value['sender'];
                                widget.repliedMessage = value['message'];

                                print(
                                    "value of replymessage ${widget.repliedMessage}");
                              });
                            },
                          ));
                    });
              },
              child: Container(

                  // margin: widget.sendbyMe
                  //   ? const EdgeInsets.only(left: 30)
                  // : const EdgeInsets.only(right: 30),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 7, right: 7),
                  decoration: BoxDecoration(
                      borderRadius: widget.sendbyMe
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                      color:
                          widget.sendbyMe ? AppColor.purpleColor : Colors.grey),
                  child:
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.recepientName.toLowerCase()}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.grayColor,
                                  letterSpacing: -0.2),
                            ),
                            Text(
                              // "${widget.senderNumber!.toLowerCase()}",
                              "+237 672973390",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.grayColor,
                                  letterSpacing: -0.2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),

                        // THIS IS CHECKING  IF THE CURRENT USER REPLIED TO A
                        // MESSAGE OR NOT

                        if (widget.repliedMessage.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.h),
                            decoration: BoxDecoration(
                                color: widget.sendbyMe
                                    ? AppColor.purpleColor!.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.5)),
                            child: Row(
                              children: [
                                // if(widget.repliedMessage.isNotEmpty)
                                Container(
                                  height: 30.h,
                                  width: 2.h,
                                  decoration: BoxDecoration(
                                      color: widget.sendbyMe
                                          ? AppColor.cardColor
                                          : AppColor.whiteColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                ),

                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  child: Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.recepientName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color: AppColor.greenColor,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                        ),
                                        SizedBox(
                                          width: 130.w,
                                          child: Text(
                                              "${widget.repliedMessage}",
                                              overflow: TextOverflow.ellipsis,
                                              // softWrap: true,
                                              // textWidthBasis: TextWidthBasis.parent,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Text(widget.message.trim(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("${widget.time}",style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!))
                      ])),
            ),
          ),
        ),
      ),
    );

    */
  }
}
