import 'package:flutter/material.dart';
import 'package:njadia/src/core/chats%20functionality/screen/create_group_page.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';

import '../core/style.dart';
import '../../utils/button_card.dart';
import '../../utils/contact_card.dart';
import '../../utils/custom_popup_menu.dart';
import '../model/chat_model.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
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

  final List<PopupMenuItem> items = [
    PopupMenuItem(
      child: Text("Invite a friend"),
      value: "Invite a friend",
    ),
    PopupMenuItem(
      child: Text("Contacts"),
      value: "Contacts",
    ),
    PopupMenuItem(
      child: Text("Refresh"),
      value: "Refresh",
    ),
    PopupMenuItem(
      child: Text("Help"),
      value: "Help",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: primaryWhite,
            )),
        backgroundColor: AppColor.lightButtonColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Contact",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: primaryWhite),
            ),
            Text(
              "240 contacts",
              style:
                  TextStyle(fontSize: 13, color: primaryWhite.withOpacity(0.5)),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 26,
                color: primaryWhite,
              )),
          CustomPopUpMenu(items: items)
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            if (index == 0)
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateGroupPage()));
                  },
                  child: ButtonCard(name: "New group", icon: Icons.book));
            else if (index == 1)
              return ButtonCard(
                name: "New contact",
                icon: Icons.person_add,
              );
            // return ContactCard(
            //   contact: contacts[index],
            // );
            return Text("");
          }),

          
    );
  }
}
