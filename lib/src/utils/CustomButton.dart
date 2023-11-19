import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/style/appfont.dart';
import '../constants/style/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPress,
      required this.text,
      this.icon = Icons.arrow_forward,
      this.image = "",
      this.height = 0,
      this.width = 0,
      this.isActive = true,
      this.borderRadius = 12,
      this.textColor = true,
      this.iconColor = AppColor.whiteColor,
      this.containerColor = AppColor.greenColor,
      this.borderColor = AppColor.greenColor});
  final VoidCallback onPress;
  final String text;
  final double height;
  final double borderRadius;
  final double width;
  final IconData? icon;
  final String? image;
  final bool? isActive;
  final bool textColor;
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
              style:Theme.of(context).textTheme.displayMedium!.copyWith(color:textColor? Theme.of(context).textTheme.displayLarge!.color:AppColor.whiteColor,  )
            ),
          ),
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Icon(
                icon,
                color: Theme.of(context).iconTheme.color,
                size: 14,
              ),
            )
        ]),
      ),
    );
  }
}
