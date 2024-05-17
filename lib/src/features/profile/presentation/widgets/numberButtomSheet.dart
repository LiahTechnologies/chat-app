import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/warning.dart';

class ChangeMobileNumber extends StatelessWidget {
  ChangeMobileNumber({super.key});
  final TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Enter Your Number",
          style: Theme.of(context)
              .textTheme
              .titleLarge!),
        
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).iconTheme.color!,
                )),
            width: 300.w,
            child: TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter number", border: InputBorder.none),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomButton(
          onPress: () {
            if (numberController.text.isNotEmpty)
              BackScreen(context: context);
            else
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomWarning(
                      text: "Field Can not be empty",
                    );
                  });
          },
          text: "Done",
          icon: null,
          textColor: false,
        )
      ],
    );
  }
}
