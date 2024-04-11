import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_bloc.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_event.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_state.dart';

import '../../../../core/common/helper_function.dart';

import '../../domain/entities/chat.dart';
import '../widget/chatTile.dart';

class DirectMessage extends StatelessWidget {
  DirectMessage({super.key});

  final TextEditingController searchController = TextEditingController();
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  
  
  // @override
  // void initState() {
  //   getUserData();

  //   super.initState();
  // }


  String userId = '';
  String userName = '';
  String recipientName = "";
  Stream? chat;
  Stream<Chat>? lastChat;



//
  // getUserData() async {
  //   await HelperFunction.getUserName().then((value) {
  //     setState(() {
  //       userName = value;
  //     });
  //   });

  //   await HelperFunction.getUserID().then((value) {
  //     setState(() {
  //       userId = value;
  //     });
  //   });

  // await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
  //     .getUserChats()
  //     .then((snapshot) {
  //   setState(() {
  //     chat = snapshot;
  //   });
  // });

  // getChatandAdmin();
  // }



  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }



  void getChattLastMessage({chatId}) {
    // DatabaseServices(uid: userId).getChatMessages(chatId).then((val) {
    //   setState(() {
    //     // lastChat = val;
    //   });
    // });
  }



// await chatCollection.doc(chatId).update({
  //   'message': chatMessages["message"],
  //   "messageId": chatMessages["messageId"],
  //   'sender': chatMessages["sender"],
  //   "replyMessage": chatMessages["replyMessage"],
  //   "replySender": chatMessages["replySender"],
  //   "senderId": chatMessages["sendId"],
  //   "recepientId": chatMessages["recepientId"],
  //   'time': chatMessages["time"],
  // });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Chats",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        return RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: () async {
            context.read<ChatBloc>().add(OnChatLoaded());
            // await getUserData();
          },
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [grouplist()],
              ),
            ),
          ),
        );
      }),
    );
  }



// get the last message

  Widget getLastMessage() {
    return BlocBuilder<ChatBloc,ChatState>(
      builder: (context,state) {
        return StreamBuilder(
            stream: lastChat,
            builder: (context, snapshot) {
              return state.chat.messages.length>0
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            print(
                                "The last message and sender is ${state.chat.name}  ${state.chat.messages[index]}");
        
                            return Text(
                              "${state.chat.name}  ${state.chat.messages[index]}",
                              style: Theme.of(context).textTheme.displaySmall,
                            );
                          }),
                    )
                  : Text("");
            });
      }
    );
  }

  grouplist() {
    return BlocBuilder<ChatBloc,ChatState>(
      builder: (context,state) {
        return StreamBuilder(
            stream: chat,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  if (snapshot.data['chats'].length != 0) {
                    // getChattLastMessage(chatId:snapshot.data['chats'][Index]);
        
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data['chats'].length,
                        itemBuilder: (context, index) {
                          var reverseIndex =
                              snapshot.data['chats'].length - index - 1;
                          print(
                              "THE LSIST OF CHAT USERS ARE: ${snapshot.data['chats'][index]}");
                          return ChatTile(
                            groupId: snapshot.data['chats'][index],
                            lastMessage: Text("getLastMessage()"),
                            userName:
                                "${snapshot.data['firstName'] + " " + snapshot.data['lastName']}",
                            recepientId: snapshot.data['chats'][index],
                            isDirectMessage: true,
                          );
                        });
                  } else {
                    return Center(
                        child: Text(
                      "No Chat",
                    ));
                    // return noGroupWidget();
                  }
                } else {
                  return Text("No");
                  // return noGroupWidget();
                }
              } else {
                return Container(
                    height: 560.h,
                    child: const Center(child: Text("No chats Created")));
              }
            });
      }
    );
  }
}
