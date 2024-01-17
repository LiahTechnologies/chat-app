import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class JoinGroup extends StatelessWidget {
  JoinGroup({super.key});
  final TextEditingController linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.greenColor,
                  ),
                  label: Text(
                    "Back",
                    style: AppFonts.defaultFonts,
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Join a Njangi Group",
              style: AppFonts.heading1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("Enter an invite below to join an existing Njangi group",
                style: AppFonts.defaultFonts),
            SizedBox(
              height: 40.h,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("INVITE LINK", style: AppFonts.heading1)),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: linkController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Example",
                style: AppFonts.heading2,
              ),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Invites should look like',
                  style: AppFonts.defaultFonts),
              TextSpan(
                  text:
                      ' https://njadia.liah./thStanfk or https://njadia.liah/ekondo-savings',
                  style: AppFonts.defaultFontsBold3)
            ])),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(
              onPress: () {
                Get.toNamed(AppRoutes.ADDCONTACT);
              },
              text: "Join Njangi",
              width: 300.w,
              icon: null,
              borderRadius: 10,
            )
          ],
        ),
      ),
    ));
  }
}
