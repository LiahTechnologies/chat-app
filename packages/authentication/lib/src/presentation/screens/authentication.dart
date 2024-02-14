import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../../../../chat/helper/helper_function.dart';
import 'package:njadia/src/features/authentication/screens/login/view/login.dart';
import 'package:njadia/src/features/onboarding/onboardingScreen.dart';
import 'package:njadia/src/features/onboarding_refine/onboarding_welcome.dart';
import 'package:njadia/src/routing/approutes.dart';

import '../../../common/helper_function.dart';

class Authenentication extends StatelessWidget {
  const Authenentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: HelperFunction.getUserLoggedInData(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return LoginScreen();
              } else {
                // return OnboardingWelcome();
                return OnBoardingScreens();
              }
            }));
  }
}
