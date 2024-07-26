

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:swipe_to/swipe_to.dart';


import '../../../../core/common/constants/style/style.dart';
import '../../../../core/model/messagemodel.dart';
import '../../../../core/utils/custom_popup_menu.dart';
import '../../../../utils/messages.dart';
import '../../../group_chat/data/model/group_chat_model.dart';
import '../../../group_chat/domain/entities/reply-message.dart';
import '../../../group_chat/presentation/widgets/attarachment-widget.dart';
import '../../domain/entities/chat.dart';
import '../bloc/private-socket-bloc.dart';
import '../bloc/private-socket-event.dart';
import '../bloc/private-socket-state.dart';




class PrivateChatRoom extends StatefulWidget {
  const PrivateChatRoom({super.key,  required this. user});
  final UserProfile user;
  
  @override
  State<PrivateChatRoom> createState() => _PrivateChatRoomState();
}

class _PrivateChatRoomState extends State<PrivateChatRoom> {
  late PrivateSocketBloc socketBloc;
  List<MessageEntity> messages = [];

   ReplyMessage replyMessage = ReplyMessage(userName: "", message: "",messageId: "");

  bool isReplyMessage = false;
  final TextEditingController controller = TextEditingController();
  bool showEmoji = false;


  FocusNode focusNode = FocusNode();

  final List<PopupMenuItem> items =const [
    PopupMenuItem(
      child: Text("View Contact"),
      value: "View Contact",
    ),
    PopupMenuItem(
      child:  Text("Media, link and docs"),
      value: "Media, link and docs",
    ),
    PopupMenuItem(
      child: Text("Whatsap web"),
      value: "Whatsapp web",
    ),
    PopupMenuItem(
      child: Text("Search"),
      value: "Search",
    ),
    PopupMenuItem(
      child: Text("Mute notifications"),
      value: "Mute notifications",
    ),
    PopupMenuItem(
      child: Text("Wallpaper"),
      value: "wallpaper",
    ),
  ];

  @override
  void initState() {


    socketBloc = BlocProvider.of<PrivateSocketBloc>(context);
    socketBloc.add(ConnectSocketEvent());
    socketBloc.add(FetchInitialMessagesEvent(groupId:widget.user.uid));
    
    getUid();
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }


late String currentUser;
getUid() async{ 
   currentUser = await HelperFunction.getUserID();
}
/*

  void connect() {
    socket = IO.io("http://192.168.0.106:5000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect(); //connect the Socket.IO Client to the Server

    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print(socket.connected);
      print("USER SOCKET ID IS:${socket.id}");
    });

    socket.emit(
    'join', "chatId");


    //listen for incoming messages from the Server.

    //listens when the client is disconnected from the Server
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  */

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CHAT BACKGROUND IMAGE
        Image.asset(
          "",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),

        Scaffold(
          backgroundColor: Colors.blueGrey.shade400,
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
                    child: const Icon(
                      Icons.arrow_back,
                      color: primaryWhite,
                    )),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: Image.asset(widget.user.profile,)
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
                      widget.user.firstName,
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
                  icon: const Icon(
                    Icons.call,
                    color: primaryWhite,
                  )),
              CustomPopUpMenu(items: items,onSelected: (v){},)
            ],
          ),

          body: BlocBuilder<PrivateSocketBloc, SocketState>(
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

            // setState(() {
              messages.add(state.message);
            // });
            return buildMessageList();


          } else if (state is SocketErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } 
          
          else {
            return Center(child: Text('Disconnected'));
          }
        },
      ),
         /* body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (showEmoji) {
                  setState(() {
                    showEmoji = false;
                  });
                } else {
                  Navigator.pop(context);
                }

                return Future.value(false);
              },
              child: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height - 144,
                      child: ListView.builder(
                          itemCount: messages.length,
                          
                          itemBuilder: (context, index) => Text("")
                          // MessageList(
                          //       messageEntity: messages[index],
                          //     )
                              
                              )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                      color: AppColor.darkIconColor,
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
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
                                                              attarchCard());
                                                    },
                                                    icon:const Icon(
                                                        Icons.attach_file)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                       const Icon(Icons.camera_alt))
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Type a message",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ))),




                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      controller.text.isEmpty
                                          ? Icons.mic
                                          : Icons.send,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () async{


                                      final currentUser = await HelperFunction.getUserID();
                                     
                                     


                                      socket.emit("newMessage",
                                       MessageModel(messageId: "messageId", message: controller.text, messageReceiver: "messageReceiver", messageSender: currentUser, replyMessage: "replyMessage", replySender: "you", chatId: "chatId", dateTime: "dateTime").toJson()

                                      );

                                      controller.clear();

                                      
                                    },
                                  ),
                                ),
                              )





                            ],
                          ),
                          // emojiWidget(controller),
                        ],
                      )),
                ],
              ),
            ),
          ),
          */
        ),
      ],
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
                                      print("THE CURRENT STATE OF isReplyMessage is $isReplyMessage");

                    setState(() {
                      isReplyMessage=true;
                      replyMessage.message= messages[index].message;
                      replyMessage.userName= messages[index].messageSender;
                      replyMessage.messageId= messages[index].messageId!;
                    });
                    print("THE CURRENT STATE OF isReplyMessage is $isReplyMessage");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: MessageList(
                                        messageEntity: messages[index],
                                        uid: currentUser,
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
                            margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                            child: Stack(
                              
                              children: [
                                Positioned(
                                
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 60,
                                      child: Card(
                                          color: AppColor.darkIconColor,
                                          margin: EdgeInsets.only(
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
                                                                                        
                                                            decoration: BoxDecoration(
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
                                        
                                        
                                       
                                                                  
                                        final message= GroupChatModel(chatId: widget.user.uid,  message: controller.text, messageSender: currentUser, replyMessage: replyMessage.message, replySender: replyMessage.userName, dateTime: DateTime.now().timeZoneName);
                                                                  
                                        socketBloc.add(SendMessageEvent('privateMessage', message));
                                       
                                        messages.add(message);
                                                                  
                                                                  
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







/*
  Widget attarchCard() {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.insert_drive_file,
                      text: "Document",
                      color: Colors.indigo),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.camera_alt,
                      text: "Camera",
                      color: Colors.pink),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.insert_photo,
                      text: "Photo",
                      color: Colors.purple),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.headset, text: "Audio", color: Colors.orange),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.location_pin,
                      text: "Location",
                      color: Colors.teal),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.person, text: "Contact", color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      {required IconData icon, required String text, required Color color}) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: primaryWhite,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("$text")
        ],
      ),
    );
  }

  // Widget emojiWidget(TextEditingController controller) {
  //   return Offstage(
  //     offstage: showEmoji,
  //     child: EmojiPicker(
  //       textEditingController: controller,
  //       // scrollController: _scrollController,
  //       config: Config(
  //         height: 256,
  //         checkPlatformCompatibility: true,
  //         emojiViewConfig: EmojiViewConfig(
  //           // Issue: https://github.com/flutter/flutter/issues/28894
  //           emojiSizeMax: 28 *
  //               (foundation.defaultTargetPlatform == TargetPlatform.iOS
  //                   ? 1.2
  //                   : 1.0),
  //         ),
  //         swapCategoryAndBottomBar: false,
  //         skinToneConfig: const SkinToneConfig(),
  //         categoryViewConfig: const CategoryViewConfig(),
  //         bottomActionBarConfig: const BottomActionBarConfig(),
  //         searchViewConfig: const SearchViewConfig(),
  //       ),
  //     ),
  //   );
  // }

  */

