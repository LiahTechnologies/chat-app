import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/utils/cached_network_image.dart';
import 'package:njadia/src/core/utils/chatroom.dart';
import '../../features/direct message/domain/entities/chat.dart';
import '../common/constants/style/style.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel, required this.onTap});
  final Chat chatModel;
  
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap
        
      ,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 23,
              child: chatModel.profilePic.isNotEmpty?
              
              cachedNetworkImage(url: chatModel.profilePic):
               Image.asset(AppImages.PERSON),
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
