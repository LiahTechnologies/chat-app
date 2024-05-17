import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import '../../../../core/common/constants/style/color.dart';

class GroupTile extends StatefulWidget {
  final String? userName;
  final String? groupid;
  final String groupName;
  final bool? isDirectMessage;
  final String? recepientId;

  const GroupTile(
      {super.key,
      required this.groupName,
      this.userName,
      this.groupid,
      this.isDirectMessage = false,
      this.recepientId = ""});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  // Stream<QuerySnapshot>? lastChat;

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  void getChatandAdmin() {
    // DatabaseServices().getChats(widget.groupid!).then((val) {
    //   setState(() {
    //     // lastChat = val;
    //   });
    // });

    // getLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // NextScreen(
        //   context: context,
        //   page: ChatPage(
        //       groupId: widget.groupid!,
        //       groupName: widget.groupName,
        //       userName: widget.groupName),
        // );
       
      },
      child: Container(
        height: 50.h,
        width: 500.w,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        // padding: const EdgeInsets.only(bottom: 16),

          child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pinkAccent,
                child: Text(
                  widget.groupName.substring(0, 1).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                widget.groupName,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              // subtitle: getLastMessage(),
              trailing: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).iconTheme.color),
                child: Center(
                    child: Text(
                  "22",
                  style: Theme.of(context).textTheme.displayMedium,
                )),
              ))
      ),
    );
  }
}
