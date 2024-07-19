import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/attarachment-widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../core/common/constants/style/color.dart';
import '../../../../core/common/constants/style/style.dart';
import '../../../../core/common/helper_function.dart';
import '../../../../core/utils/custom_popup_menu.dart';
import '../../../../utils/messages.dart';
import '../../../direct message/domain/entities/chat.dart';
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




  final List<PopupMenuItem> items = [
    PopupMenuItem(
      child: Text("View Contact"),
      value: "View Contact",
    ),
    PopupMenuItem(
      child: Text("Media, link and docs"),
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

  bool showEmoji = false;

  FocusNode focusNode = FocusNode();
    final TextEditingController controller = TextEditingController();

late String currentUser;
getUid() async{ 
   currentUser = await HelperFunction.getUserID();
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
                    child: Icon(
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
                margin: EdgeInsets.only(right: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.userName,
                      style: TextStyle(
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
                  icon: Icon(
                    Icons.videocam,
                    color: primaryWhite,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: primaryWhite,
                  )),
              CustomPopUpMenu(items: items)
            ],
          ),
      body: BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state) {

          if (state is SocketConnectingState) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          else if (state is SocketConnectedState) {

            return  buildMessageList();
            /*
            Column(
              children: [
                Expanded(
                  child:

                  // ListView.builder(
                  //   itemCount: messages.length,
                  //   itemBuilder: (context, index) {
                  //     return  MessageList(
                  //                   messageEntity: messages[index],
                  //                   uid: currentUser,
                  //                 );
                  //   },
                  // ),
                ),

                chatInputWidget()

      /*
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (text) {
                      socketBloc.add(SendMessageEvent('sendMessage', {'content': text}));
                    },
                    decoration: InputDecoration(
                      labelText: 'Send a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                */



              ],
            );
            */
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
    );
  }



  Widget buildMessageList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageList(
                                    messageEntity: messages[index],
                                    uid: currentUser,
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
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 2),
                                    child: CircleAvatar(
                                      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                                      radius: 25,
                                      child: IconButton(
                                        icon: Icon(
                                          
                                          controller.text.isEmpty
                                              ? Icons.mic
                                              : Icons.send,
                                              color: Colors.white,
                                          // color: Theme.of(context).iconTheme.color,
                                        ),
                                        onPressed: () {
                                          
                                          
                                         

                                          final message= GroupChatModel(chatId: widget.chatModel.chatId,  message: controller.text, messageSender: currentUser, replyMessage: "", replySender: "", dateTime: "12:00pm");

                                          socketBloc.add(SendMessageEvent('groupMessage', message));
                                         
                                          messages.add(message);


                                          // context.read<GroupChatBloc>().add(OnSentGroupMessage(message:message, groupId:widget.chatModel.chatId  ));
                                        //   socket.emit("newGroupMessage",
                                        //    message
                  
                                        //   );
                                        // socket.on("newGroupMessage",(data){
                                        //       print("LIVE MESSAGE  $data");
                                        // });



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
                              // emojiWidget(controller),
                            ],
                          ));
  }
}
