import 'package:flutter/material.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/naviagtion.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key, this.text = "Friend request sent"});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      Image.asset(AppImages.SEND_ICON, width: 90, height: 60),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      Center(
        child: CustomButton(
            
            // textColor: AppColor.greenColor,
            width: 90,
            height: 50,
            icon: null,
            onPress: () {
              BackScreen(context: context);
            },
            text: "Return"),
      )
    ]));
  }
}
