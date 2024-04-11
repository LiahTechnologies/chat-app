import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/common/constants/style/color.dart';

class CustomDots extends StatelessWidget {
  const CustomDots({super.key, required this.index,required this.position});
  final  int index;
  final  int position;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
          color: index != position ? AppColor.greenColor : Colors.black87,
          borderRadius: BorderRadius.circular(25)),
    );
  }
}
