import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';
import 'package:njadia/src/utils/CustomButton.dart';

import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

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
                    child: const CustomBackArrow()),

                
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Join a Njangi Group",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("Enter an invite below to join an existing Njangi group",
                    style: Theme.of(context).textTheme.displaySmall),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("INVITE LINK",
                        style: Theme.of(context).textTheme.bodyMedium)),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
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
                  child: Text("Example",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Invites should look like',
                      style: Theme.of(context).textTheme.displaySmall),
                  TextSpan(
                      text:
                          ' https://njadia.liah./thStanfk or https://njadia.liah/ekondo-savings',
                      style: Theme.of(context).textTheme.labelSmall)
                ])),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  onPress: () {
                    NextScreen(context: context, page: AddContacts());
                    // Get.toNamed(AppRoutes.ADDCONTACT);
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
