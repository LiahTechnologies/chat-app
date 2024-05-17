import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';

import '../../../../core/model/chat_model.dart';
import '../../../../core/utils/custom_card.dart';
import 'group_template_option.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key});

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "John Doe",
        icon: "/",
        isGroup: false,
        time: "8:00",
        status: "Frontend Developer",
        currentMessage: "this is no school tomorrow"),
    ChatModel(
        name: "Flutter Developers",
        icon: "/",
        isGroup: true,
        time: "11:00",
        status: "Devops engineer",
        currentMessage: "Hi How are you doing"),
    ChatModel(
        name: "Bernard",
        icon: "/",
        isGroup: false,
        time: "2:00",
        status: "Mobile developer",
        currentMessage: "Ok Thanks"),
  ];

  List<PopupMenuItem> popItems = [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: AppColor.lightButtonColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GroupTemplateOption()));
        },
        child:  Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Njangi Groups",
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white),
        ),
        // centerTitle: true,

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Theme.of(context).bottomAppBarTheme.shadowColor)),
          CustomPopUpMenu(items: popItems)
        ],
      ),
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => CustomCard(
                chatModel: chats[index],
              )),
    );
  }
}
