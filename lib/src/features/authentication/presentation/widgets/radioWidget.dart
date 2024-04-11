import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget(
      {super.key,
      required this.text,
      required this.onTap,
      required this.active,
      required this.index});
  final String text;

  final int active;
  final int index;
  final Function onTap;

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int isRadioChecked = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 20.h,
      child: Row(
        children: [
          Radio(
              activeColor: AppColor.greenColor,
              value: widget.index,
              groupValue: widget.active,
              onChanged: (value) {
                widget.onTap(value);
              }),
          Text(widget.text, style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
    );
  }
}
