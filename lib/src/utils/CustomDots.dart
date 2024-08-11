import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/device-height-and-width.dart';

import '../core/common/constants/style/color.dart';

class CustomDots extends StatelessWidget {
  const CustomDots({super.key, required this.index,required this.position});
  final  int index;
  final  int position;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      width: deviceOrientation(context)==Orientation.portrait?10.h:deviceWidth(context)/40,
      height: deviceOrientation(context)==Orientation.portrait?10.h:deviceWidth(context)/40.h,
      decoration: BoxDecoration(
          color: index == position ? Colors.teal : Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(25)),
    );
  }
}
