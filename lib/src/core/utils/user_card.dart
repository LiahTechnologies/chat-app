import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/core/utils/encryption.dart';

import '../common/constants/style/style.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.messageEntity, required this.previousMessageSenderId});
  final MessageEntity messageEntity;
  final String previousMessageSenderId;
  @override
  Widget build(BuildContext context) {


      return ChatBubble(
        alignment: Alignment.centerRight,
        backGroundColor: primaryGreen.withOpacity(0.7),
        // margin: EdgeInsets.only(right:5, left: 55 ),
          clipper: previousMessageSenderId==messageEntity.senderId? ChatBubbleClipper5(type: BubbleType.sendBubble):ChatBubbleClipper9(type: BubbleType.sendBubble),
            child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 285,
        maxWidth: MediaQuery.of(context).size.width - 145,
          ),
              child: Stack(children: [
                         
              
                  if(messageEntity.replyMessage.isNotEmpty)
                       
              
               
               Positioned(child: Padding(padding: EdgeInsets.only(left: 3, bottom: 10,top: 2),child: 
              
              
               
                Row(
                  mainAxisSize: MainAxisSize.min,
              
              
                                                               children: [
              
              
              
                                                                   Container(
                                                                     
                                                                     margin: const EdgeInsets.only(right: 5,bottom: 8),
                                                             
                                                                                          width: 5,
                                                                                                 height: 30,
                                                                                                 
                                                                                                 decoration: BoxDecoration(
                                                                                                    color: Theme.of(context).appBarTheme.backgroundColor,
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                    topLeft: Radius.circular(10),
                                                                                                    bottomLeft: Radius.circular(10)
                                                                                                    )
                                                                                                             
                                                                                                 ),
                                                                                                ),
                                                                                                 Flexible(
                                                                                                   child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                     children: [
                                                                                                     Text("${messageEntity.replySender}",overflow:TextOverflow.ellipsis,maxLines: 1,),
                                                                                                     Text("${EncryptionClass.decryption(messageEntity.replyMessage)}",overflow:TextOverflow.ellipsis,maxLines: 1,)
                                                                                                       ],
                                                                       ),
                                                                        ),
              
              
                                                                                                 
                                                               ],
                                                             )
               
               ,)
               
               ),
                                                      
                Positioned(
                  // bottom: 4,
                  child: Padding(
                    padding:  EdgeInsets.only(
                         top:messageEntity.replyMessage.isNotEmpty? 35:2, right: 15,bottom: 15
                        ),
                    child: Text(
                      "${EncryptionClass.decryption(messageEntity.message)}",
                      style:const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              
              
                Positioned(
                  bottom: -3,
                  right: -4,
                  left: 5,
                  child: Expanded(
                    // width: 67,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${messageEntity.time}",
                          style: TextStyle(fontSize: 11, color: Colors.grey[100]),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.done,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              
              
              
                
              
              ]),
            )
      );
    
   
    
  }
}
