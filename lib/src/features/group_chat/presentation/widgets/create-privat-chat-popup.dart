import 'dart:core';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';

class SeeChatProfile extends StatelessWidget {
   SeeChatProfile({super.key, required this.profileImag, required this.chat, required this.videoCall});
  final String profileImag;
  final VoidCallback chat;
  final VoidCallback videoCall;
  // fina void Function vh;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      // Align(
      //   alignment: Alignment.topRight,
      //   child: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      Center(
          child: 
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImag),
      )),
      SizedBox(
        height: 10.h,
      ),
      Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed:chat, icon: LineIcon(Icons.chat)),
          IconButton(onPressed:videoCall, icon: LineIcon(Icons.video_call)),
          IconButton(onPressed:chat, icon: LineIcon(Icons.chat))
        ],
      )),
    ]));
  }

 
}
