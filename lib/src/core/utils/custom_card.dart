import 'package:flutter/material.dart';
import '../../features/direct message/domain/entities/chat.dart';
import '../chats functionality/screen/individual_page.dart';
import '../chats functionality/core/style.dart';
import '../model/chat_model.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel});
  final Chat chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IndividualPage(chatModel: chatModel,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 33,
              child: Icon(
                chatModel.isGroup ? Icons.group : Icons.person,
                color: primaryWhite,
                size: 32,
              ),
              backgroundColor: Theme.of(context).iconTheme.color!.withOpacity(0.7),
            ),
            trailing: Text("${chatModel.time}"),
            title: Text(
              "${chatModel.userName}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 5,
                ),
                Text("${chatModel.lastMessage}"),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
