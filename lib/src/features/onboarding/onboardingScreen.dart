import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/constants/style/appfont.dart';
import '../../common/constants/style/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/utils/CustomDots.dart';

import '../../routing/approutes.dart';


class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});
  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
            onPageChanged: (index) {
              // controller.initialPage=index;
            },
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              /**
               * THIS  IS FOR THE FIRST ONBOARDING SCREEN
               */

              Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 2,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.h,
                            left: 10.w,
                            child: Image.asset("assets/images/Hands Give.png"),
                          ),
                          Positioned(
                            top: 100.h,
                            child:
                                Image.asset("assets/images/Hands Exchange.png"),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Welcome to Njadia",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Empowering you to save more with \nguidiance and  security",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    //  loading dots and next button

                    LoadingDots(number: 3.5, index: 1),
                  ],
                ),
              ),

              /**
               * THIS IS FOR THE SECOND ONBOARDING SCREEN
               * 
               */

              Container(
                  height: Get.height / 2,
                  child: Column(children: [
                    Stack(
                      children: [
                        Positioned(
                            // top: 0,
                            child: Image.asset("assets/images/round.png")),
                        Positioned(
                            top: 190.h,
                            // left: 0,
                            child: Image.asset("assets/images/Hands Pinch.png"))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Introduction to \nNjadia",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Njadia, a time-honored trandition, unites communities through a collection of saving journey. Experience the power of communal finance as we automate group saving with safety and trust",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    LoadingDots(number: 5, index: 2),
                  ])),

              /**
               * THIS IS FOR THE THIRD ONBOARDING SCREEN
               */

              Container(
                  child: Column(children: [
                SvgPicture.asset("assets/images/amico.svg"),
                Text(
                  "How it works",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Text(
                    "Join or create a group, contribute regualarly.Pooled savings grow. Automated rotation. Receive payout. Trustworthy community support. safe and secure. A brighter financial future awaits action protected",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                LoadingDots(number: 4, index: 3),
              ]))
              /**
               * THIS IS FOR THE FOURTH ONBOARIDNG SCREEN
               */
            ]),
      ),
    );
  }

  Widget LoadingDots({index, number}) {
    return Container(
      height: Get.height / number,
      width: Get.width,
      child: Stack(
        children: [
          Positioned(
              bottom: 80.h,
              left: 160.w,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomDots(index: index, position: 1),
                    CustomDots(index: index, position: 2),
                    CustomDots(index: index, position: 3),
                  ],
                ),
              )),
          Positioned(
              left: 160.w,
              bottom: 5.h,
              child: CustomButton(
                icon: Icons.arrow_forward,
                onPress: index != 3
                    ? () => controller.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut)
                    : () => Get.toNamed(AppRoutes.SIGNUP),
                text: "NEXT",
              ))
        ],
      ),
    );
  }
}
