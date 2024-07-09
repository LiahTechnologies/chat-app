import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/create_group/presentation/widgets/custom_card_items.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/utils/customGetxButtomSheet.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import 'select_group_member.dart';

class GroupMenuPage extends StatelessWidget {
  const GroupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            customGetxBottomsheet(menuClicked(context),context);
                          },
                          icon: Icon(
                            Icons.menu_outlined,
                            color: Theme.of(context).iconTheme.color,
                          )),
                      Text(
                        "# General",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_outlined,
                            color: Theme.of(context).iconTheme.color,
                          )),
                      IconButton(
                          onPressed: () {
                            customGetxBottomsheet(personClicked(context),context);
                          },
                          icon: Icon(
                            Icons.person_outline,
                            color: Theme.of(context).iconTheme.color,
                          ))
                    ],
                  )
                ],
              ),
              Container(
                height: 360.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Theme.of(context).iconTheme.color!.withOpacity(0.1)),
                  child: Center(
                      child: Text(
                    "#",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 35),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    "Welcome to Ekondo Njangi",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    "This is your brand new, shiny Njangi group.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              CustomCardItems(
                  image: AppImages.TWO_PEOPLE_ICON,
                  text: "set up your njangi group",
                  onTap: () {
                    NextScreen(context: context, page: SelectGroupMember());
                  }),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_outlined)),
                    SizedBox(
                      width: 230.w,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Message@Miles Nguimisong",
                            border: InputBorder.none),
                      ),
                    ),
                    Image.asset(AppImages.FACE_ICON),
                    Image.asset(AppImages.VOICE_RECORD),
                    // Icon(Icons.record)
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  menuClicked(BuildContext  context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        Image.asset(AppImages.NJANGI_ICON),
        Text(
          "Finish setting up your njangi group",
          style: Theme.of(context).textTheme.displayMedium
        ),
        Text.rich(TextSpan(children: [
          TextSpan(text: "you have completed", style: Theme.of(context).textTheme.displayMedium),
          TextSpan(text: " 0 of 3 steps", style: Theme.of(context).textTheme.displayMedium)
        ])),
        CustomCardItems(
            image: AppImages.GROUP_DEFAULT_ICON,
            text: "Invit your members",
            onTap: () {}),
        CustomCardItems(
            image: AppImages.UPLOAD_GROUP_ICON,
            text: "Upload a Group icon",
            onTap: () {}),
        CustomCardItems(
            image: AppImages.ENVELOP_INVITE_ICON,
            text: "Send your first message",
            onTap: () {}),
        Text(
          "skip these step",
          style: Theme.of(context).textTheme.displayMedium,
        )
      ]),
    );
  }

  personClicked(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.ENVELOP_INVITE_ICON,
            ),
            Text(
              "Invit your members to this njangi",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "share this link with your members and they'll  ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "automatically join your Njangi",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Container(
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Image.asset(AppImages.LINK_ICON),
                      hintText: "https://njadia.liah/URtaJK8F")),
            ),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Expires in 7days",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onPress: () {},
              text: "Share link",
              icon: null,
              width: 300,
            )
          ],
        ),
      ),
    );
  }
}
