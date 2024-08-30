
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/utils/encryption.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';


import '../../features/direct message/presentation/widget/chatroom.dart';
import '../../features/group_chat/presentation/bloc/group-socket-bloc.dart';
import '../../features/group_chat/presentation/bloc/group-socket-event.dart';
import '../../features/group_chat/presentation/bloc/group-socket-state.dart';
import '../../features/group_chat/presentation/widgets/create-privat-chat-popup.dart';
import '../entities/message_entity.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({super.key, required this.messageEntity,required this.previousMessageSenderId});
  final MessageEntity messageEntity;
   final String previousMessageSenderId;
  @override
  Widget build(BuildContext context) {

    print("THIS IS THE MESSAGE $messageEntity");
    return Row(
      children: [
    
    
        
        BlocListener<SocketBloc,SocketState>(
          listener: (BuildContext context, SocketState state) { 
            if(state is  PrivateChatCreated)
            
                nextScreen(context, PrivateChatRoom(user: UserProfile( profile: AppImages.PERSON, firstName: messageEntity.messageSender, lastName: "", uid: messageEntity.messageSender),));
           },
          child: InkWell(
            onTap: () async{
              final uid = await HelperFunction.getUserID();
              
              showDialog(context: context, builder:(context)=>SeeChatProfile(profileImag: AppImages.PERSON, chat: () { 
                context.read<SocketBloc>().add(OnAddChat(uid: uid, receiverId: messageEntity.senderId));
               }, videoCall: () {  },));
            },
            child:const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(AppImages.PERSON),
            ),
          ),
        ),
        
    
        ChatBubble(
          backGroundColor: Colors.grey[400],
         clipper: previousMessageSenderId==messageEntity.senderId? ChatBubbleClipper5(type: BubbleType.receiverBubble):ChatBubbleClipper9(type: BubbleType.receiverBubble),

        //  clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),

          alignment: Alignment.centerLeft,
          child: Container(
             constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 165,
            ),
            child: Stack(children: [
                    
                    
                if(messageEntity.replyMessage.isNotEmpty)
                         
                    
             
             Positioned(
              child: Padding(padding: EdgeInsets.only(left: 10, bottom: 10,top: 10),child: 
                    
            
             
              Row(
                mainAxisSize: MainAxisSize.min,
                    
                    
                                                             children: [
                    
                    
                    
                                                                 Container(
                                                                   
                                                                   margin: const EdgeInsets.only(right: 5,bottom: 8),
                                                           
                                                                                        width: 5,
                                                                                               height: 30,
                                                                                               
                                                                                               decoration: BoxDecoration(
                                                                                                  color: Color.fromARGB(183, 1, 47, 58),
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
                  left:messageEntity.message.length<=10? 30:15.0, bottom: messageEntity.message.length>=10?10:25, right: messageEntity.message.length>=10?10:25, top:messageEntity.replyMessage.isNotEmpty? 50:10 ),
                  child: Text(
                    "${messageEntity.message}",
                    style:const TextStyle(fontSize: 16),
                  ),
                ),
              ),
                    
                    
              Positioned(
                bottom: 8,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      "${messageEntity.time}",
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    )
                  ],
                ),
              ),
                    
                    
                    
              
                    
            ]),
          ),
        ),
      ],
    );
  }
}
