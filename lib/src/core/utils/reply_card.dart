
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/chat.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';


import '../../features/direct message/presentation/widget/chatroom.dart';
import '../../features/group_chat/presentation/bloc/group-socket-bloc.dart';
import '../../features/group_chat/presentation/bloc/group-socket-event.dart';
import '../../features/group_chat/presentation/bloc/group-socket-state.dart';
import '../../features/group_chat/presentation/widgets/create-privat-chat-popup.dart';
import '../common/constants/style/color.dart';
import '../entities/message_entity.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.messageEntity});
    final MessageEntity messageEntity;


  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Row(
        
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
                  context.read<SocketBloc>().add(OnAddChat(uid: uid, receiverId: messageEntity.messageSender));
                 }, videoCall: () {  },));
              },
              child:const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppImages.PERSON),
              ),
            ),
          ),
          
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-125,
          
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(15))),
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              color: Theme.of(context).colorScheme.tertiary,
              child: Stack(children: [
          

              if(messageEntity.replyMessage.isNotEmpty)
         

           
           Positioned(
            
            child: Padding(padding:const EdgeInsets.only(left: 10, bottom: 35,top: 5),child: 

          
           

            Row(
              mainAxisSize: MainAxisSize.min,
              
               children: [
            
            
                         Container(
                                                                 
                         margin: const EdgeInsets.only(right: 5,bottom: 8),
                                                         
                         width: 5,
                         height: 30,
                                                                                             
                        decoration: BoxDecoration(
                         color: Theme.of(context).appBarTheme.backgroundColor,
                         borderRadius:const BorderRadius.only(
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
                                      Text(messageEntity.replySender,overflow:TextOverflow.ellipsis,maxLines: 1,),
                                      Text(messageEntity.replyMessage,overflow:TextOverflow.ellipsis,maxLines: 1,)
                                       ],
                                         ),
                       ),
            
            
                                                                                             
                    ],
                   )
           
           ,)
           
           ),
              
                                                  
              Positioned(
                bottom: 8,
                left: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:4.0),
                  child: Text("${messageEntity.message}",style: TextStyle(fontSize: 16),),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 10,
                child: 
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${messageEntity.dateTime}",style: TextStyle(fontSize: 11,color: Colors.grey[600]),),
                        
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
                  
              )
            ]),),
          ),
        ],
      ),
    );
  }
}