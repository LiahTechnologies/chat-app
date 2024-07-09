// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_bloc.dart';
// import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_event.dart';
// import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_message_state.dart';

// import '../../../../core/common/helper_function.dart';

// import '../../domain/entities/chat.dart';
// import '../widget/chatTile.dart';

// class DirectMessage extends StatelessWidget {
//   DirectMessage({super.key});

//   final TextEditingController searchController = TextEditingController();
//   GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();

//   // @override
//   // void initState() {
//   //   getUserData();

//   //   super.initState();
//   // }

//   String userId = '';
//   String userName = '';
//   String recipientName = "";
//   Stream? chat;
//   Stream<Chat>? lastChat;

// //
//   // getUserData() async {
//   //   await HelperFunction.getUserName().then((value) {
//   //     setState(() {
//   //       userName = value;
//   //     });
//   //   });

//   //   await HelperFunction.getUserID().then((value) {
//   //     setState(() {
//   //       userId = value;
//   //     });
//   //   });

//   // await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
//   //     .getUserChats()
//   //     .then((snapshot) {
//   //   setState(() {
//   //     chat = snapshot;
//   //   });
//   // });

//   // getChatandAdmin();
//   // }

//   String getId(String res) {
//     return res.substring(9, res.indexOf('_'));
//   }

//   String getName(String res) {
//     return res.substring(res.indexOf("_") + 1);
//   }

//   void getChattLastMessage({chatId}) {
//     // DatabaseServices(uid: userId).getChatMessages(chatId).then((val) {
//     //   setState(() {
//     //     // lastChat = val;
//     //   });
//     // });
//   }

// // await chatCollection.doc(chatId).update({
//   //   'message': chatMessages["message"],
//   //   "messageId": chatMessages["messageId"],
//   //   'sender': chatMessages["sender"],
//   //   "replyMessage": chatMessages["replyMessage"],
//   //   "replySender": chatMessages["replySender"],
//   //   "senderId": chatMessages["sendId"],
//   //   "recepientId": chatMessages["recepientId"],
//   //   'time': chatMessages["time"],
//   // });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Chats",
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
//         return RefreshIndicator(
//           key: refreshIndicatorKey,
//           onRefresh: () async {
//             context.read<ChatBloc>().add(OnChatLoaded());
//             // await getUserData();
//           },
//           child: Container(
//             width: double.infinity,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [grouplist()],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   int index = 2;

// // get the last message

//   Widget getLastMessage() {
//     return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
//       return StreamBuilder(
//           stream: lastChat,
//           builder: (context, snapshot) {
//             return index > 0
//                 ? Expanded(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           // print(
//                           //     "The last message and sender is ${state.chat.d}  ${state.chat.messages[index]}");

//                           return Text(
//                             "thisis",
//                             style: Theme.of(context).textTheme.displaySmall,
//                           );
//                         }),
//                   )
//                 : Text("");
//           });
//     });
//   }

//   grouplist() {
//     return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
//       return StreamBuilder(
//           stream: chat,
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               if (snapshot.data != null) {
//                 if (snapshot.data['chats'].length != 0) {
//                   // getChattLastMessage(chatId:snapshot.data['chats'][Index]);

//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data['chats'].length,
//                       itemBuilder: (context, index) {
//                         var reverseIndex =
//                             snapshot.data['chats'].length - index - 1;
//                         print(
//                             "THE LSIST OF CHAT USERS ARE: ${snapshot.data['chats'][index]}");
//                         return ChatTile(
//                           groupId: snapshot.data['chats'][index],
//                           lastMessage: Text("getLastMessage()"),
//                           userName:
//                               "${snapshot.data['firstName'] + " " + snapshot.data['lastName']}",
//                           recepientId: snapshot.data['chats'][index],
//                           isDirectMessage: true,
//                         );
//                       });
//                 } else {
//                   return Center(
//                       child: Text(
//                     "No Chat",
//                   ));
//                   // return noGroupWidget();
//                 }
//               } else {
//                 return Text("No");
//                 // return noGroupWidget();
//               }
//             } else {
//               return Container(
//                   height: 560.h,
//                   child: const Center(child: Text("No chats Created")));
//             }
//           });
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';

import '../../../../core/model/chat_model.dart';
import '../../../../core/utils/custom_card.dart';
import '../../domain/entities/chat.dart';
import '../bloc/chat_message_bloc.dart';
import '../bloc/chat_message_state.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
 late List<Chat> chats ;

  

  List<PopupMenuItem> popItems = [
    PopupMenuItem(child: Text("time")),
  ];

  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Chats",
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white)
        ),
        // centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          CustomPopUpMenu(items: popItems)
        ],
      ),
      body: BlocBuilder<ChatBloc,ChatState>(
        builder: (context,state) {
          return ListView.builder(
              itemCount: state.chat.length,
              itemBuilder: (context, index) => CustomCard(
                    chatModel: chats[index],
                  ));
        }
      ),
    );
  }
}
