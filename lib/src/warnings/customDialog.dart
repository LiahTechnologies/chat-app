import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/utils/customGetxButtomSheet.dart';

import '../features/profile/presentation/widgets/numberButtomSheet.dart';

class CustomDailog extends StatelessWidget {
  const CustomDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            "What do you want to do?",
            style: AppFonts.defaultFonts,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                // borderColor: AppColor.greenColor,
                // containerColor: AppColor.whiteColor,
                // textColor: AppColor.greenColor,
                width: 105.w,
                height: 50.h,
                icon: null,
                onPress: () {
                  Get.back();
                  customGetxBottomsheet(ChangeMobileNumber());
                },
                text: "Edit Number"),
            SizedBox(
              width: 10.w,
            ),
            CustomButton(
                // borderColor: AppColor.greenColor,
                // containerColor: AppColor.gr,
                // textColor: AppColor.greenColor,
                width: 105.w,
                height: 50.h,
                icon: null,
                onPress: () {
                  Get.back();
                  customGetxBottomsheet(ChangeMobileNumber());
                },
                text: "Add Number"),
            // SizedBox(width: 10.w,),
            //           CustomButton(
            //           borderColor: AppColor.greenColor,
            //           containerColor: AppColor.whiteColor,
            //           textColor: AppColor.greenColor,
            //           width: 97.w,
            //           height: 50.h,
            //           icon: null,
            //           onPress: () {
            //             Get.back();
            //           },
            //           text: "Cancel"),SizedBox(width: 10.w,),
          ],
        ),
      )
    ]));
  }
}
