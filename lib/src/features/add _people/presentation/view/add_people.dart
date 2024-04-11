import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/customeNotification.dart';

import '../../../../core/common/constants/style/appfont.dart';

class AddUserLink extends StatelessWidget {
  final TextEditingController linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        BackScreen(context: context);
                      },
                      child: Text(
                        "Skip",
                        style: AppFonts.defaultFonts,
                      )),
                ),
                Text(
                  "Add some people",
                  style: AppFonts.heading3,
                ),
                Text(
                  "You will need members to get the most out of your ",
                  style: AppFonts.defaultFonts,
                ),
                Text(
                  "Njangi group",
                  style: AppFonts.defaultFonts,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Image.asset(AppImages.ADD_MEMBER_LINK_ICON),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                  child: TextField(
                    controller: linkController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.link_outlined,
                          color: AppColor.greenColor,
                        ),
                        hintText: "https://njadi.liah",
                        border: InputBorder.none),
                  ),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Your invitation link should expire in 7 days.",
                      style: AppFonts.defaultFonts),
                  TextSpan(text: "Edit invite link.", style: AppFonts.heading3),
                ])),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CustomNotification();
                        });

                    
                  },
                  text: "Share Link",
                  icon: null,
                  width: 300,
                )
              ],
            )),
      ),
    );
  }
}
