import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';

import '../../../../core/common/constants/style/appfont.dart';

class SignUpDetails extends StatelessWidget {
  const SignUpDetails(
      {super.key,
      required this.firstNamecontroller,
      required this.lastNamecontroller,
      
      });

  final TextEditingController firstNamecontroller;
  final TextEditingController lastNamecontroller;

  Widget inputDetails(BuildContext context,
      {required String label,
      required TextEditingController controller,
      required width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: Theme.of(context).textTheme.displayMedium,),
        Container(
          width: width,
          padding: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).iconTheme.color!),
              borderRadius: BorderRadius.circular(15)),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            inputDetails(context,
                label: "First Name",
                controller: firstNamecontroller,
                width: 130.w),
            inputDetails(context,
                label: "Last Name",
                controller: lastNamecontroller,
                width: 130.w),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
      
      
      
      
      ],
    );
  }
}
