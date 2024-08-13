import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/core/utils/currentime.dart';
import 'package:njadia/src/core/utils/encryption.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/bloc/approval-bloc.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/bloc/approval-state.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import 'package:njadia/src/features/group_chat/domain/entities/reply-message.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/view/approve-to-join.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/attarachment-widget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../../../core/common/constants/style/color.dart';
import '../../../../core/common/constants/style/style.dart';
import '../../../../core/common/helper_function.dart';
import '../../../../core/common/urls.dart';
import '../../../../core/utils/custom_popup_menu.dart';
import '../../../../utils/messages.dart';
import '../../../approve-tojoin-group/presentation/bloc/approval-event.dart';
import '../../../create_group/presentation/view/select_contact_page.dart';
import '../../../direct message/domain/entities/chat.dart';
import '../../../payment/presentation/view/select_group_member.dart';
import '../bloc/group-socket-bloc.dart';
import '../bloc/group-socket-event.dart';
import '../bloc/group-socket-state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:encrypt/encrypt.dart' as encrypt;

class GroupChatRoom extends StatefulWidget {

   const GroupChatRoom({super.key, required this.chatModel});
  final Chat chatModel;
  @override
  _GroupChatRoomState createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
 late MessageEntity replyMessage;
  List<MessageEntity> messages = [];
    late IO.Socket socket;
  late SocketBloc socketBloc;
  final audio = AudioPlayer();

  @override
  void initState() {
     audioPlayer();
    super.initState();
    _scrollController=ScrollController();
    socketBloc = BlocProvider.of<SocketBloc>(context);
    socketBloc.add(ConnectSocketEvent());
    socketBloc.add(FetchInitialMessagesEvent(groupId:widget.chatModel.chatId));
      getUid();
    connect();
    
  
  }

  @override
  void dispose() {
    // socketBloc.add(DisconnectSocketEvent());
    _scrollController.dispose();
    controller.dispose();
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

    PopupMenuItem(
      child: Text("Add members"),
      value: "Add members",
    ),
    // PopupMenuItem(
    //   child: Text("Wallpaper"),
    //   value: "wallpaper",
    // ),

    
  ];




  // ReplyMessage replyMessage = ReplyMessage(userName: "", message: "",messageId: "");

  bool isReplyMessage = false;

  bool showEmoji = false;
  bool approve= false;

  FocusNode focusNode = FocusNode();
    final TextEditingController controller = TextEditingController();
   late ScrollController _scrollController;

late String currentUser;
late String uid;
var encryptedText;

  @override
  Widget build(BuildContext context) {
  context.read<ApprovalBloc>().add(OnFetchApprovals(groupId: widget.chatModel.chatId));
  
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

                BlocBuilder<ApprovalBloc,ApprovalState>(
                  builder: (context,state) {

                    if(state is ApprovalsLoadded){
                      if(state.approvals.length>0)
                      return         
                          Badge(
                                largeSize: 20.0,
                                alignment: Alignment.topCenter,
                                backgroundColor: Colors.red,
                                label: Text("${state.approvals.length}"),
                                child: CustomPopUpMenu(
                                  items: items,
                                onSelected: (value){
                                  if(value=="Payment")nextScreen(context, SelectGroupMember(groupName: widget.chatModel.userName,groupId: widget.chatModel.chatId,));
                                
                                  if(value=="Approve to join")nextScreen(context, ApproveToJoin(groupId: widget.chatModel.chatId));
                                              
                                  if(value =="Add members") nextScreen(context,const SelectContactPage(isCreatGroup: false,));
                                
                                },
                                
                                
                                ),
                                  );
                    }
                    return             
                      CustomPopUpMenu(
                      items: items,
                    onSelected: (value){
                      if(value=="Payment")nextScreen(context, SelectGroupMember(groupName: widget.chatModel.userName,groupId: widget.chatModel.chatId,));
                     if(value=="Approve to join")nextScreen(context, ApproveToJoin(groupId: widget.chatModel.chatId,));
                    
                    if(value =="Add members") nextScreen(context,const SelectContactPage(isCreatGroup: false,));
                    });
                    
                  }
                ),
              
            ],
          ),
      body: PageStorage(
        bucket: PageStorageBucket(),
        key: PageStorageKey(1),
        child: BlocBuilder<SocketBloc, SocketState>(
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
            
            // else if (state is SocketMessageReceivedState) {
        
            //   print("CURRENT STATE EMITTED ${state.message}");
            //     final data = GroupChatModel.fromJson(state.message);
            //   // setState(() {
            //     messages.add(MessageEntity(message: data.message, senderId: data.senderId, receiverId: data.receiverId, messageSender: data.messageSender, replyMessage: data.replyMessage, replySender: data.replySender, dateTime: data.dateTime));
            //   // });
            //   return buildMessageList();
        
        
            // } 
            
            else if (state is SocketErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } 
            
            else {
              return const Center(child: Text('Disconnected'));
            }
          },
        ),
      ),
    );
  }



  Widget buildMessageList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return SwipeTo(
                onLeftSwipe: (v){
                  setState(() {
                    isReplyMessage=true;
                    replyMessage= messages[index];
                  });
                },
             
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: InkWell(
                    onLongPress: (){
                      showBottomSheet(context: context, builder: (context)=>Container(height: 270,width: 130,child: Card(color: Colors.white,
                        elevation: 4,
                      ),));
                    },
                    child: MessageList(
                            messageEntity: messages[index],
                            uid: uid,
                                      ),
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
                      PageStorage(
                        key: PageStorageKey(2),
                        bucket: PageStorageBucket(),
                        child: Align(
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
                                                               Text("${replyMessage.messageSender}",overflow:TextOverflow.ellipsis,),
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
                                          
                                           final encryptedText = EncryptionClass.encryption(controller.text);
                                           print("THE ENCRYPTED TEXT IS $encryptedText");                    
                                          final message= GroupChatModel(chatId: widget.chatModel.chatId,  message: controller.text, messageSender: currentUser, replyMessage:isReplyMessage? replyMessage.message:"", replySender: isReplyMessage?replyMessage.messageSender:"", time: currentTime(),senderId: uid, receiverId: widget.chatModel.chatId, messageReceiver: widget.chatModel.userName);
                                            print("tHIS IS THE MESSAGE $message");                        
                                          socketBloc.add(SendMessageEvent('groupMessage', message));
                                        //  print("THIS EVENT IS BEING CALLED");
                                          messages.add(message);
                                                                                                        
                                                  setState(() {
                                                    isReplyMessage=false;
                                                    
                                                    
                                                  });                  
                                            audioPlayer();
                                            print("CLEARING THE MESSAGE");             
                                          controller.clear();
                                                                    
                                       
                                                                    
                                          // socketBloc.add(OnMessageEvent(events));
                                              scrollToEndOfList();      
                                          
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
  }




  getUid() async{ 
   uid = await HelperFunction.getUserID();
   currentUser = await HelperFunction.getUserName();
}



void connect() async {
    print("THE CONNECTION IS BEING CALLED");
    socket = IO.io(AppUrls.SOCKET_URL, <String, dynamic>{
      "query":{
          "userId":await HelperFunction.getUserID()
      },
      'transports': ['websocket'],
      "autoConnect": false,



    });
    socket.connect();

    socket.on('connect', (_) {
      print('User connected');
    });

    socket.on("OnGroup",(data) async{

         final  newMessage =await GroupChatModel.fromJson(data);
         setState(() {
           messages.add(newMessage);
           buildMessageList();
           audioPlayer();
         });
        scrollToEndOfList(); 
    });
   


    socket.on('disconnect', (_) {
      print('User disconnected');
    });
  }
  

  scrollToEndOfList(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }


   Future<void> audioPlayer()async{

    await audio.play(AssetSource("assets/sounds/message-sound.mp3"));
  }
}
