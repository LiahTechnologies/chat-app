import 'package:flutter/material.dart';
import 'package:njadia/src/core/model/chat_model.dart';

import '../../utils/contact_card.dart';
import '../core/style.dart';
import '../../utils/avtar_card.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
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

  List<ChatModel> groups = [];

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
        backgroundColor: primaryGreen,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Group",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: primaryWhite),
            ),
            Text(
              "Add participants",
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                print("THE LENGTH IS ${contacts.length}");
                if (index == 0)
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                return InkWell(
                  onTap: () {
                    if (contacts[index].isSelected == false) {
                      setState(() {
                        contacts[index].isSelected = true;
                        groups.add(contacts[index]);
                      });
                    } else {
                      setState(() {
                        contacts[index].isSelected = false;
                        groups.remove(contacts[index]);
                      });
                    }
                  },
                  child: ContactCard(
                    contact: contacts[index],
                  )
                );
              }),
          if (groups.length > 0)
            Column(
              children: [
                Container(
                  height: 75,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: contacts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (contacts[index].isSelected == true)
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  contacts[index].isSelected = false;
                                  groups.remove(contacts[index]);
                                });
                              },
                              child: AvtarCard(contact: contacts[index]));
                        else
                          return Container();
                      }),
                ),
                Divider(
                  thickness: 1,
                )
              ],
            )
        ],
      ),
    );
  }
}
