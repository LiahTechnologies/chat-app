import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../core/model/chatmodel.dart';
import '../../../../core/utils/avtar_card.dart';
import '../../../../core/utils/contact_card.dart';
import 'create_group.dart';

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
        leading: CustomBackArrow(),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "New Group",
              style:Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white) ),
            
            Text(
              "Add participants",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              )),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
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
                    ));
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
                  thickness: 0.5,
                )
              ],
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: AppColor.lightButtonColor,
        onPressed: () {
          nextScreen(context, CreateGroup());
        },
        child:  Text("Next",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),),
      ),
    );
  }
}
