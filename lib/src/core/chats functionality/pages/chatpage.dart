import 'package:flutter/material.dart';
import 'package:njadia/src/core/model/chat_model.dart';

import '../../../features/direct message/domain/entities/chat.dart';
import '../../../features/create_group/presentation/view/group_template_option.dart';
import '../core/style.dart';
import '../../utils/custom_card.dart';


class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Chat> chats = [
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGreen,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupTemplateOption()));
        },
        child: const Icon(
          Icons.chat,
          color: primaryWhite,
        ),
      ),
       backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Njangi Groups",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: chats.length, itemBuilder: (context, index) => CustomCard(chatModel: chats[index],)),
    );
  }
}
