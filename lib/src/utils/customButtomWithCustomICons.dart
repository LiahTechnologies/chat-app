import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/constants/style/appfont.dart';
import '../common/constants/style/color.dart';

class CustomButtonWithCustomIcons extends StatelessWidget {
  const CustomButtonWithCustomIcons(
      {super.key,
      required this.onPress,
      required this.text,
      required this.icon,
      this.image = "",
      this.height = 0,
      this.width = 0,
      this.isActive = true,
      this.borderRadius = 12,
      this.textColor = AppColor.whiteColor,
      this.iconColor = AppColor.whiteColor,
      this.containerColor = AppColor.greenColor,
      this.borderColor = AppColor.greenColor});
  final VoidCallback onPress;
  final String text;
  final double height;
  final double borderRadius;
  final double width;
  final Widget icon;
  final String? image;
  final bool? isActive;
  final Color textColor;
  final Color iconColor;
  final Color containerColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? 150.w : width,
      height: height == 0 ? 40.h : height,
      decoration: BoxDecoration(
          color: isActive! ? containerColor : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: MaterialButton(
        onPressed: onPress,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (image!.isNotEmpty) Image.asset(image!),
          Center(
            child: Text(
              text,
              style: AppFonts.buttonColor.copyWith(color: textColor),
            ),
          ),
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: icon,
            )
        ]),
      ),
    );
  }
}
