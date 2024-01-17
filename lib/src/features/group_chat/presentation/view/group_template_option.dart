import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/custom_card_items.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/utils/customGetxButtomSheet.dart';
import 'package:njadia/src/warnings/coming%20_soon.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../common/constants/style/appAsset.dart';

class GroupTemplateOption extends StatelessWidget {
  const GroupTemplateOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
       appBar: AppBar(
        leading:CustomBackArrow(),
       title: Text("Create Your Njadia Group",
                style: Theme.of(context).textTheme.titleMedium),centerTitle: true, ),
        body: SafeArea(
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: C),
            // SizedBox(
            //   height: 6.h,
            // ),
            

            SizedBox(
              height: 10.h,
            ),
            Text("Begin your collective saving journey. Experience the power",
                style: Theme.of(context).textTheme.displayMedium),
            Text(
              "of communal finance",
              style: Theme.of(context).textTheme.displayMedium,
            ),

            SizedBox(height: 10.h),
            CustomCardItems(
              image: AppImages.WORLD_ICON,
              text: "create my own ",
              onTap: () {
                Get.toNamed(AppRoutes.GROUP_CATEGORYg);
              },
            ),
            SizedBox(height: 10.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text("START FROM A TEMPLATE",
                      style: Theme.of(context).textTheme.displayMedium),
                )),
            SizedBox(height: 10.h),

            CustomCardItems(
              image: AppImages.WORLD1_ICON,
              text: "Famers Njangi ",
              onTap: () {
                 showDialog(
                      context: context,
                      builder: (context) {
                        return ComiingSoon();
                      });
              },
            ),
            
            CustomCardItems(
              image: AppImages.WORLD2_ICON,
              text: "Smaill Businesses ",
              onTap: () {
                 showDialog(
                      context: context,
                      builder: (context) {
                        return ComiingSoon();
                      });
              },
            ),

            CustomCardItems(
              image: AppImages.WORLD_ICON,
              text: "Friends",
              onTap: () {
                 showDialog(
                      context: context,
                      builder: (context) {
                        return ComiingSoon();
                      });
              },
            ),

            CustomCardItems(
                image: AppImages.WORLD3_ICON,
                text: "Friends ",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ComiingSoon();
                      });
                }),

            // CustomCardItems(
            // image: AppImages.WORLD4_ICON, text: "Local Community "),

            CustomCardItems(
              image: AppImages.WORLD5_ICON,
              text: "Local Community ",
              onTap: () {
                showDialog(
                      context: context,
                      builder: (context) {
                        return ComiingSoon();
                      });
              },
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text("Have an invitation?",
                  style: Theme.of(context).textTheme.displayMedium),
            ),

            CustomButton(
              onPress: () {
                Get.toNamed(AppRoutes.JOINGROUP);
              },
              text: "Join Njangi",
              icon: null,
              width: 250.w,
              borderRadius: 12,
            )
          ],
        ),
      ),
    ));
  }
}
