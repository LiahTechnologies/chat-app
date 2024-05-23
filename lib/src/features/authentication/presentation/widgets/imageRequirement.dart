import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/constants/style/appfont.dart';
import '../../../../core/common/constants/style/color.dart';

class ImageRequirementWidget extends StatelessWidget {
  const ImageRequirementWidget(
      {super.key, required this.text, this.show = false, this .left = 35});
  final String text;
  final bool show;
  final double left;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !show
                ? Container(
                    margin: EdgeInsets.only(left:left.w, right: 10.w),
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15)),
                  )
                : Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: Icon(Icons.warning_amber_rounded)),
            Text(text,style:Theme.of(context).textTheme.displayMedium),
          ]),
    );
  }
}
