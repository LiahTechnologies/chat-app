import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({super.key, required this.index, required this.userOTP});
  final index;
  final ValueChanged<String> userOTP;

  OTPOnchange(value, index, BuildContext context) {
    if (value.length == 1 && index != 6) FocusScope.of(context).nextFocus();

    userOTP(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //     topLeft: index == 1 ? Radius.circular(15) : Radius.circular(0),
          //     bottomLeft: index == 1 ? Radius.circular(15) : Radius.circular(0),
          //     topRight: index == 6 ? Radius.circular(15) : Radius.circular(0),
          //     bottomRight:
          //         index == 6 ? Radius.circular(15) : Radius.circular(0)
          //         ),

          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.only(right: 0.02.w,left: 5),
      height: 40.h,
      width: 43.8.w,
      child: SizedBox(
        width: 6.w,
        height: 50.h,
        child: TextField(
          // maxLength: 1,
          autofocus: true,
          autofillHints: List.empty(),
          onChanged: (value) => OTPOnchange(value, index, context),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Color(0xff1FAF67)),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              // hintText: "phone number",
              border: InputBorder.none),
        ),
      ),
    );
  }
}
