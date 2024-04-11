import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/constants/style/color.dart';

class ChatBubble extends StatelessWidget {

   ChatBubble({
    super.key,
    // required this.text,
    required this.isCurrentUser,
    required this.sender,
    // required this.messageId,
    // required this.groupId,
    this.senderNumber,
    this.time,
    this.senderId,
    required this.repliedMessage,
    required this.recepientName,
    required this.text,
  });
  // final String text;
  final bool isCurrentUser;

  String repliedMessage;
  String recepientName;
  // final String messageId;
  // final String groupId;
  final String? senderNumber;
  final String? time;
  final String? senderId;
  final String? sender;
  final String text;
  // const ChatBubble({
  //   Key? key,
  //   required this.text,
  //   required this.isCurrentUser,
  //   required this.user,
  //    required this.repliedMessage,
  //   required this.recepientName,
   
  // }) : super(key: key);
  // final String text;
  // final bool isCurrentUser;
  
  // String repliedMessage;
  // String recepientName;
  //  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
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
             Column(
              mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      

                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "${recepientName.toLowerCase()}",
                        //       textAlign: TextAlign.center,
                        //       style: const TextStyle(
                        //           fontSize: 6,
                        //           fontWeight: FontWeight.bold,
                        //           color: AppColor.grayColor,
                        //           letterSpacing: -0.2),
                        //     ),
                        //     Text(
                        //       // "${senderNumber!.toLowerCase()}",
                        //       "+237 672973390",
                        //       textAlign: TextAlign.center,
                        //       style: const TextStyle(
                        //           fontSize: 6,
                        //           fontWeight: FontWeight.bold,
                        //           color: AppColor.grayColor,
                        //           letterSpacing: -0.2),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 1),

                        // THIS IS CHECKING  IF THE CURRENT USER REPLIED TO A
                        // MESSAGE OR NOT

                        if (repliedMessage.isNotEmpty)
                          GestureDetector(
                            onTap: (){
                              
                            },
                            child: DecoratedBox(
                             
                              decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? AppColor.purpleColor.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.5)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 3,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: isCurrentUser
                                            ? AppColor.cardColor
                                            : AppColor.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                  ),
                              
                                  SizedBox(
                                    width: 5.w,
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
                                                    fontSize: 10,
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
                                                    .displayMedium!.copyWith(color: AppColor.grayColor)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 4,),
                        Text(
                          
                          text.trim(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),
                        SizedBox(height: 2,),
                          Text("${time}",style: Theme.of(context)
                                                  .textTheme
                                                   .displayMedium!,
                                                   textAlign: TextAlign.end,
                                                   )
                      ]),
        ),
        ),
      ),
    );
  }
}
