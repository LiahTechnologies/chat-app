

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_list_event.dart';

import '../../domain/entities/chat.dart';
import '../bloc/chat_list_bloc.dart';
import '../bloc/chat_list_state.dart';
import '../widget/chatroom.dart';
import '../widget/custom-chat-list.dart';

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
    context.read<ChatListBloc>().add(OnFetchChats());
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
          CustomPopUpMenu(items: popItems,onSelected: (v){},)
        ],
      ),
      body: BlocBuilder<ChatListBloc,ChatState>(
        builder: (context,state) {
          if(state is ChatLoaded)
          return ListView.builder(
              itemCount: state.chat.length,
              itemBuilder: (context, index) => CustomChatCard(
                    user: state.chat[index],
                    onTap: (){
                      Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrivateChatRoom(user: state.chat[index])));
                    },
                  ));
        
        if(state is ChatLoading)

          return Center(
              child: CircularProgressIndicator(),
            );

        return  Center(child: Text("Empty",style:  Theme.of(context).textTheme.displayMedium,),);
        }
      ),
    );
  }
}



