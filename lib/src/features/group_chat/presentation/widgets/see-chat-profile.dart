import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class SeeChatProfile extends StatelessWidget {
  const SeeChatProfile({super.key, required this.profileImag, required this.chat, required this.videoCall});
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
            radius: 75.w,
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
