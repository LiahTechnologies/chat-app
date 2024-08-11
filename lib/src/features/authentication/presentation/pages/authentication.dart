import 'package:flutter/material.dart';
import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
// import '../../../../../../chat/helper/helper_function.dart';
import 'package:njadia/src/features/authentication/presentation/pages/login.dart';
import 'package:njadia/src/features/authentication/presentation/pages/signup.dart';
import 'package:njadia/src/features/home/presentation/view/home.dart';
import 'package:njadia/src/features/onboarding/onboardingScreen.dart';


import '../../../../core/common/helper_function.dart';

class Authenentication extends StatelessWidget {
  const Authenentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: HelperFunction.getUserLoggedInData(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                 print("LOGIN STATUS  is true: ${snapshot.data}");
                return HomePage();
              } else {
                print("LOGIN STATUS ${snapshot.data}");
                return LoginScreen();
                // return OnBoardingScreens();
              }
            }));
  }
}
