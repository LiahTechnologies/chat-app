import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/theme/themes.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.text,
      required this.controller,
      required this.hint,
      this.isBorderColor = false,
      this.height = 80,
      this.width = 350});
  final String text;
  final ValueChanged<String> controller;
  final String hint;
  final double width;
  final double height;
  final bool isBorderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          border: Border.all(
              color: isBorderColor ?Theme.of(context).iconTheme.color! : Colors.transparent)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Container(
            child: TextField(
              style: Theme.of(context).textTheme.displayMedium,
                onChanged: (value) {
                  controller(value);
                },
                decoration:
                    InputDecoration( hintText: hint)),
          ),
        ],
      ),
    );
  }
}
