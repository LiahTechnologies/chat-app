import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

import '../common/constants/style/style.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.messageEntity});
  final MessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {


      return ChatBubble(
        alignment: Alignment.centerRight,
        backGroundColor: primaryGreen.withOpacity(0.7),
        // margin: EdgeInsets.only(right:5, left: 55 ),
          clipper: ChatBubbleClipper9(type: BubbleType.sendBubble),
            child: Container(
                  constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 145,
          ),
              child: Stack(children: [
                         
              
                  if(messageEntity.replyMessage.isNotEmpty)
                       
              
               
               Positioned(child: Padding(padding: EdgeInsets.only(left: 10, bottom: 10,top: 10),child: 
              
              
               
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
                                                                                                     Text("${messageEntity.replyMessage}",overflow:TextOverflow.ellipsis,maxLines: 1,)
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
                        left:messageEntity.message.length<=10? 20:15.0, bottom: messageEntity.message.length>=10?10:25, right: messageEntity.message.length>=10?10:45, top:messageEntity.replyMessage.isNotEmpty? 50:10 
                        ),
                    child: Text(
                      "${messageEntity.message}",
                      style:const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              
              
                Positioned(
                  bottom: 8,
                  right: 1,
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
    
    
    /*
    print("THIS IS THE MESSAGE $messageEntity");
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 145,
        ),
        child: 
    
        
        
        
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color:primaryGreen.withOpacity(0.7),
          child: ChatBubble(
            
            child: 
            
            Stack(children: [
           
            
                if(messageEntity.replyMessage.isNotEmpty)
                     
            
             
             Positioned(child: Padding(padding: EdgeInsets.only(left: 10, bottom: 10,top: 10),child: 
            
            
             
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
                                                                                                   Text("${messageEntity.replyMessage}",overflow:TextOverflow.ellipsis,maxLines: 1,)
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
                      left:messageEntity.message.length<=10? 39:15.0, bottom: messageEntity.message.length>=10?10:25, right: messageEntity.message.length>=10?10:25, top:messageEntity.replyMessage.isNotEmpty? 50:10 ),
                  child: Text(
                    "${messageEntity.message}",
                    style:const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            
            
              Positioned(
                bottom: 8,
                right: 1,
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
          ),
        ),
      ),
    );
*/
    
  }
}
