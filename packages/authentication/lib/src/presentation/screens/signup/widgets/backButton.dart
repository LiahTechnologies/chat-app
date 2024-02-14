import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/style/appfont.dart';
import '../../../../../common/constants/style/color.dart';


class BackButton extends StatelessWidget {
 BackButton({super.key});
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return   Align(
    alignment: Alignment.topLeft,
    child: Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        width: 90.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: AppColor.greenColor,
            borderRadius: BorderRadius.circular(15)),
        child: MaterialButton(
            onPressed: () => controller.previousPage(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: AppColor.whiteColor,
                ),
                Text("Back", style: AppFonts.buttonColor),
              ],
            ))),
  );
  }
}