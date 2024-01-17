import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/see-chat-profile.dart';

import '../../../../common/constants/style/appAsset.dart';
import '../../../../common/constants/style/color.dart';
import '../../../../routing/approutes.dart';
import '../../../../warnings/longpressDialogue.dart';
import '../../../direct message/presentation/view/chat.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    // required this.text,
    required this.isCurrentUser,
    required this.sender,
    required this.messageId,
    required this.chatId,
    this.senderNumber,
    this.time,
    this.senderId,
    required this.repliedMessage,
    required this.recepientName,
    required this.message,
  });
  // final String text;
  final bool isCurrentUser;

  String repliedMessage;
  String recepientName;
  final String messageId;
  final String chatId;
  final String? senderNumber;
  final String? time;
  final String? senderId;
  final String? sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: !isCurrentUser? GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => SeeChatProfile(
                    profileImag: AppImages.PERSON,
                    chat: () async {
                      print("THE CHAT ICON WAS CLICKED");
                      Get.to(
                        
                        DirectMessageChat(
                        profileImg: AppImages.PERSON,
                        senderName: sender,
                        senderId: senderId!,
                        chatId: chatId,
                        canCreate: true,
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
      ):Text(""),
      title: Padding(
        // asymmetric padding
        padding: EdgeInsets.fromLTRB(
          isCurrentUser ? 64.0 : 16.0,
          4,
          isCurrentUser ? 16.0 : 64.0,
          4,
        ),
        child: Align(
          // align the child within the container
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: DecoratedBox(
            // chat bubble decoration
            decoration: BoxDecoration(
              color: isCurrentUser ? AppColor.purpleColor : Colors.grey,
              borderRadius: isCurrentUser
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),

              //
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child:  
              GestureDetector(
                onTap: (){
                   showDialog(
                    context: context,
                    builder: (context) {
                      return Align(
                          alignment: Alignment.topLeft,
                          child: CustomLongPress(
                            groupId: chatId,
                            messageId: messageId,
                            message: message,
                            recepientName: recepientName,
                            senderTapped: (value) {
                              
                                recepientName = value['sender'];
                                repliedMessage = value['message'];
 
                            },
                          ));
                    });
                },
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                             SizedBox(height: 5,),
                             
                         Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          
                              Text(
                                "${recepientName.toLowerCase()}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.grayColor,
                                    letterSpacing: -0.2),
                              ),
                              Text(
                                // "${senderNumber!.toLowerCase()}",
                                "+237 672973390",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.grayColor,
                                    letterSpacing: -0.2),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                
                          // THIS IS CHECKING  IF THE CURRENT USER REPLIED TO A
                          // MESSAGE OR NOT
                
                          if (repliedMessage.isNotEmpty)
                            DecoratedBox(
                             
                              decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? AppColor.purpleColor!.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.5)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: isCurrentUser
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
                                            "${recepientName}",
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
                                            width: 120.w,
                                            child: Text(
                                                "${repliedMessage}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!.copyWith(color: AppColor.secondary)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                          Text(message.trim(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white)),
                
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("${time}",style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!))
                        ]),
              )
                      ),
              
              // Column(
              //   children: [
              //     Text(message, style: Theme.of(context).textTheme.labelMedium),
              //     Text("${sender!}",
              //         style: Theme.of(context).textTheme.labelMedium),
              //   ],
              // ),


            ),
          ),
        ),
      
    );
  }
}
