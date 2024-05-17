import 'package:flutter/material.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';

import '../utils/naviagtion.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key, this.firstButton="Return"});
  final bool showHiddenButton = false;
  final String firstButton;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
      Image.asset(AppImages.SEND_ICON, width: 90, height: 60),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Friend request sent",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),

      Row(
        
        children: [
        CustomButton(
            
            width: 90,
            height: 50,
            icon: null,
            onPress: () {
              BackScreen(context: context);
            },
            text: firstButton),
      if (showHiddenButton)
        CustomButton(
           
            width: 90,
            height: 50,
            icon: null,
            onPress: () {
              BackScreen(context: context);
            },
            text: "Return"),

      if (showHiddenButton)
      CustomButton(
         
          width: 90,
          height: 50,
          icon: null,
          onPress: () {
            BackScreen(context: context);
          },
          text: "Return")
      ],)
      
    ]));
  }
}
