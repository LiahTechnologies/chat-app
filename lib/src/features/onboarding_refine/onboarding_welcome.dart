import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/utils/button.dart';

class OnboardingWelcome extends StatelessWidget {
  const OnboardingWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Stack(

        children: [
          Container(
            color: AppColor.greenColor,
            height: double.infinity,
          ),
          Center(
            child: Text("Contect and Save\nmoney with people",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.whiteColor,fontSize: 30),)),
          
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.5, horizontal: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 AppButton(onPress: (){}, text: "Login",borderColor: AppColor.blackColor,),
                  AppButton(onPress: (){}, text: "Sign up",containerColor: AppColor.whiteColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}