import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:njadia/src/features/group_chat/domain/entities/reply-message.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/view/approve-to-join.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/attarachment-widget.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../core/common/constants/style/color.dart';
import '../../../../core/common/constants/style/style.dart';
import '../../../../core/common/helper_function.dart';
import '../../../../core/utils/custom_popup_menu.dart';
import '../../../../utils/messages.dart';
import '../../../direct message/domain/entities/chat.dart';
import '../../../payment/presentation/view/select_group_member.dart';
import '../bloc/group-socket-bloc.dart';
import '../bloc/group-socket-event.dart';
import '../bloc/group-socket-state.dart';


class GroupChatRoom extends StatefulWidget {

   const GroupChatRoom({super.key, required this.chatModel});
  final Chat chatModel;
  @override
  _GroupChatRoomState createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  late SocketBloc socketBloc;
  List<MessageEntity> messages = [];
  

  @override
  void initState() {
    super.initState();
    socketBloc = BlocProvider.of<SocketBloc>(context);
    socketBloc.add(ConnectSocketEvent());
    socketBloc.add(FetchInitialMessagesEvent(groupId:widget.chatModel.chatId));
    
    // socketBloc.onMessage('OnGroup', (data) async{
    //   final newMessage= await MessageEntity.fromjson(data);
    //   setState(() {
       
    //    print("onGroup Message $newMessage");
    //     messages.add(newMessage);
    //   });
    // });
    getUid();
  }

  @override
  void dispose() {
    socketBloc.add(DisconnectSocketEvent());
    super.dispose();
  }




  final List<PopupMenuItem> items = const[
    PopupMenuItem(
      child: Text("View Contact"),
      value: "View Contact",
    ),
    PopupMenuItem(
      child: Text("Generate ballot numbers"),
      value: "Generate ballot numbers",
    ),

    PopupMenuItem(
      child: Text("Payment"),
      value: "Payment",
    ),

    PopupMenuItem(
      child: Text("Approve to join"),
      value: "Approve to join",
    ),

    // PopupMenuItem(
    //   child: Text("Mute notifications"),
    //   value: "Mute notifications",
    // ),
    // PopupMenuItem(
    //   child: Text("Wallpaper"),
    //   value: "wallpaper",
    // ),

    
  ];




   ReplyMessage replyMessage = ReplyMessage(userName: "", message: "",messageId: "");

  bool isReplyMessage = false;

  bool showEmoji = false;
  bool approve= false;

  FocusNode focusNode = FocusNode();
    final TextEditingController controller = TextEditingController();

late String currentUser;
late String uid;
getUid() async{ 
   uid = await HelperFunction.getUserID();
   currentUser = await HelperFunction.getUserName();
}

  @override
  Widget build(BuildContext context) {
    // context.read<SocketBloc>().add(ConnectSocketEvent());
  
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            // centerTitle: true,
            leadingWidth: 70,
            titleSpacing: 1,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:const Icon(
                      Icons.arrow_back,
                      color: primaryWhite,
                    )),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    widget.chatModel.isGroup ? Icons.group : Icons.person,
                    size: 22,
                  ),
                )
              ],
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin:const EdgeInsets.only(right: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.userName,
                      style:const TextStyle(
                          color: primaryWhite,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    Text(
                      "lastseen: 9:00am",
                      style: TextStyle(
                          color: primaryWhite.withOpacity(0.5), fontSize: 13),
                    )
                  ],
                ),
              ),
            ),

            actions: [
              IconButton(
                  onPressed: () {},
                  icon:const Icon(
                    Icons.videocam,
                    color: primaryWhite,
                  )),
              IconButton(
                  onPressed: () {},
                  icon:const Icon(
                    Icons.call,
                    color: primaryWhite,
                  )),

              approve?
              Badge(
                largeSize: 20.0,
                alignment: Alignment.topCenter,
                backgroundColor: Colors.red,
                label: Text("2"),
                child: CustomPopUpMenu(
                  items: items,
                onSelected: (value){
                  if(value=="Payment")nextScreen(context, SelectGroupMember(groupName: widget.chatModel.userName,groupId: widget.chatModel.chatId,));

                  if(value=="Approve to join")nextScreen(context, ApproveToJoin(groupId: widget.chatModel.chatId));
               
                },
                
                
                ),
              ):CustomPopUpMenu(
                  items: items,
                onSelected: (value){
                  if(value=="Payment")nextScreen(context, SelectGroupMember(groupName: widget.chatModel.userName,groupId: widget.chatModel.chatId,));
                 if(value=="Approve to join")nextScreen(context, ApproveToJoin(groupId: widget.chatModel.chatId,));

                
                }),
            ],
          ),
      body: BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state) {

          if (state is SocketConnectingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          else if (state is SocketConnectedState) {

            return  buildMessageList();
          
          } 
          else if (state is InitialMessagesFetchedState) {
            messages = state.messages;
            return buildMessageList();

          } 
          
          else if (state is SocketMessageReceivedState) {

            print("CURRENT STATE EMITTED ${state.message}");
              final data = GroupChatModel.fromJson(state.message);
            // setState(() {
              messages.add(MessageEntity(message: data.message, senderId: data.senderId, receiverId: data.receiverId, messageSender: data.messageSender, replyMessage: data.replyMessage, replySender: data.replySender, dateTime: data.dateTime));
            // });
            return buildMessageList();


          } else if (state is SocketErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } 
          
          else {
            return const Center(child: Text('Disconnected'));
          }
        },
      ),
    );
  }



  Widget buildMessageList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return SwipeTo(
                onLeftSwipe: (v){


                    setState(() {
                      isReplyMessage=true;
                      replyMessage.message= messages[index].message;
                      replyMessage.userName= messages[index].messageSender;
                      replyMessage.messageId= messages[index].messageId!;
                    });

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: MessageList(
                          messageEntity: messages[index],
                          uid: uid,
                                    ),
                ),
              );
            },
          ),
        ),

            chatInputWidget()
                     
        
      ],
    );
  }

  chatInputWidget(){
    return 
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            margin:const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                            child: Stack(
                              
                              children: [
                                Positioned(
                                
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 60,
                                      child: Card(
                                          color: AppColor.darkIconColor,
                                          margin:const EdgeInsets.only(
                                              left: 2, right: 2, bottom: 8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Column(
                                           
                                            children: [
                                      if(isReplyMessage)

                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                height: 45,
                                                width: MediaQuery.of(context).size.width - 100,
                                               decoration: BoxDecoration(
                                                 color: Colors.grey[700]!.withOpacity(0.15),
                                                 borderRadius: BorderRadius.circular(15)
                                               ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      top: -10,
                                                      right: -1,
                                                      child: IconButton(onPressed: (){
                                                          setState(() {
                                                            isReplyMessage=false;
                                                          });
                                                        }, icon: Icon(Icons.close)),),
                                                    
                                                    Row(
                                                      children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 5),
                                                    
                                                            width: 5,
                                                            height: 40,
                                                                                        
                                                            decoration:const BoxDecoration(
                                                            color: AppColor.greenColor,
                                                            borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10)
                                                                                           )
                                                                                                    
                                                                                        ),
                                                                                       ),
                                                    Expanded(
                                                            child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                             children: [
                                                             Text("${replyMessage.userName}",overflow:TextOverflow.ellipsis,),
                                                            Text("${replyMessage.message}",overflow:TextOverflow.ellipsis,maxLines: 1,)
                                                                       ],
                                                                                          ),
                                                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                            
                                                            
                                                            
                                                            
                                              TextFormField(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                controller: controller,
                                                onChanged: (v) {
                                                  setState(() {
                                                    controller.text = v;
                                                  });
                                                },
                                                maxLines: 4,
                                                minLines: 1,
                                                keyboardType: TextInputType.multiline,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    prefixIcon: IconButton(
                                                      icon: Icon(Icons.emoji_emotions),
                                                      onPressed: () {
                                                        focusNode.unfocus();
                                                        focusNode.canRequestFocus =
                                                            false;
                                                            
                                                        setState(() {
                                                          showEmoji = !showEmoji;
                                                        });
                                                      },
                                                    ),
                                                    suffixIcon: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context: context,
                                                                  builder: (context) =>
                                                                      Attarachment());
                                                            },
                                                            icon:const Icon(
                                                                Icons.attach_file)),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon:
                                                                Icon(Icons.camera_alt))
                                                      ],
                                                    ),
                                                    contentPadding: EdgeInsets.all(10),
                                                    hintText: "Type a message",
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium),
                                              ),
                                            ],
                                          ))),
                                ),
                            
                            
                                Positioned(
                                 
                                  right: 1,
                                  bottom: 8,
                                  // padding: const EdgeInsets.only(
                                  //     bottom: 8.0, right: 2),
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                                    radius: 22,
                                    child: IconButton(
                                      icon: Icon(
                                        
                                        controller.text.isEmpty
                                            ? Icons.mic
                                            : Icons.send,
                                            color: Colors.white,
                                        // color: Theme.of(context).iconTheme.color,
                                      ),
                                      onPressed: () {
                                        
                                        
                                       
                                                                  
                                        final message= GroupChatModel(chatId: widget.chatModel.chatId,  message: controller.text, messageSender: currentUser, replyMessage: replyMessage.message, replySender: replyMessage.userName, dateTime: "12:00pm",senderId: uid, receiverId: widget.chatModel.chatId, messageReceiver: widget.chatModel.userName);
                                                                  
                                        socketBloc.add(SendMessageEvent('groupMessage', message));
                                       
                                        // messages.add(message);
                                                                  
                                                                  
                                        // context.read<GroupChatBloc>().add(OnSentGroupMessage(message:message, groupId:widget.chatModel.chatId  ));
                                      //   socket.emit("newGroupMessage",
                                      //    message
                                                  
                                      //   );
                                      // socket.on("newGroupMessage",(data){
                                      //       print("LIVE MESSAGE  $data");
                                      // });
                                                                  
                                                setState(() {
                                                  isReplyMessage=false;
                                                  replyMessage.message="";
                                                  replyMessage.userName="";
                                                  replyMessage.messageId="";
                                                });                  
                                                                  
                                        controller.clear();
                                        print("WAITING FOR THE EVENT");
                                                                  
                                       socketBloc.add(OnMessageEvent("OnGroup",(data){
                                                                  
                                                    print("THIS ISE THE RESPONSE $data");
                                                                  
                                                  }));
                                                                  
                                        // socketBloc.add(OnMessageEvent(events));
                                                  
                                        
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
  }
}
