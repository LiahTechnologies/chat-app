import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/utils/customGetxButtomSheet.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import '../features/profile/presentation/widgets/numberButtomSheet.dart';

class CustomDailog extends StatelessWidget {
  const CustomDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            BackScreen(context: context);
          },
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            "What do you want to do?",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
               
                width: 105.w,
                height: 50.h,
                icon: null,
                onPress: () {
                  BackScreen(context: context);
                  customGetxBottomsheet(ChangeMobileNumber(),context);
                },
                text: "Edit Number"),
            SizedBox(
              width: 10.w,
            ),
            CustomButton(
               
                width: 105.w,
                height: 50.h,
                icon: null,
                onPress: () {
                  BackScreen(context: context);
                  customGetxBottomsheet(ChangeMobileNumber(),context);
                },
                text: "Add Number"),
            
          ],
        ),
      )
    ]));
  }
}
