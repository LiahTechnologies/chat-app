import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key, this.firstButton="Return"});
  final bool showHiddenButton = false;
  final String firstButton;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      Image.asset(AppImages.SEND_ICON, width: 90, height: 60),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Friend request sent",
            style: AppFonts.defaultFonts,
          ),
        ),
      ),

      Row(
        
        children: [
        CustomButton(
            borderColor: AppColor.greenColor,
            containerColor: AppColor.whiteColor,
            // textColor: AppColor.greenColor,
            width: 90,
            height: 50,
            icon: null,
            onPress: () {
              Get.back();
            },
            text: firstButton),
      if (showHiddenButton)
        CustomButton(
            borderColor: AppColor.greenColor,
            containerColor: AppColor.whiteColor,
            // textColor: AppColor.greenColor,
            width: 90,
            height: 50,
            icon: null,
            onPress: () {
              Get.back();
            },
            text: "Return"),

      if (showHiddenButton)
      CustomButton(
          borderColor: AppColor.greenColor,
          containerColor: AppColor.whiteColor,
          // textColor: AppColor.greenColor,
          width: 90,
          height: 50,
          icon: null,
          onPress: () {
            Get.back();
          },
          text: "Return")
      ],)
      
    ]));
  }
}
