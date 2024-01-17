import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget(
      {super.key,
      this.height = 50,
      this.width = 350,
      this.marginBottom = 0,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.marginTop = 0,
      this.borderRadius = 0,
      this.text = "",
      required this.onChange});
  final double width;
  final double height;
  final double borderRadius;
  final Function onChange;
  final double marginTop;
  final double marginBottom;
  final double marginRight;
  final double marginLeft;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: marginTop,
                  bottom: marginBottom,
                  left: marginLeft,
                  right: marginRight),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              width: width.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Theme.of(context).inputDecorationTheme.iconColor!)),
              child: TextField(
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (v) => onChange(v),
                decoration: const InputDecoration(border: InputBorder.none),
              )),
        ],
      ),
    );
  }
}
