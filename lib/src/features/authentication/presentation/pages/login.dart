import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:njadia/src/features/home/presentation/view/home.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/warning.dart';

import '../../../../utils/CustomButton.dart';
import '../../../../utils/customInputWidget.dart';
import 'signup.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String email = '';
  String password = '';

  // AuthController controller =    Get.lazyPut(() => AuthController(usecase: Get.find<UserUsecase>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login to Account",
                        style: Theme.of(context).textTheme.titleMedium),
          
                    SizedBox(
                      height: 10.h,
                    ),
          
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Enter your ",
                            style: Theme.of(context).textTheme.displayLarge),
                        TextSpan(
                            text: "Email & Password",
                            style: Theme.of(context).textTheme.displayLarge),
                        TextSpan(
                            text: " Below.",
                            style: Theme.of(context).textTheme.displayLarge),
                      ])),
                    ),
          
                SizedBox(height: 9,),
                    Text(
                        "We will send  a 6 digit code to verify your phone  number",
                        style: Theme.of(context).textTheme.displayMedium),
                   
                    SizedBox(height: 5,),
                   
                    CustomInputWidget(
                        borderRadius: 12,
                        marginTop: 12,
                        text: "Email",
                        onChange: (v) {
                          email = v;
                        }),
                    CustomInputWidget(
                        borderRadius: 12,
                        marginTop: 12,
                        text: "Password",
                        onChange: (v) {
                          password = v;
                        }),
          
                    BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            onPress: () async {
                              if (email.isNotEmpty || password.isNotEmpty) {
                          
          
                                context.read<AuthBloc>().add(
                                    OnLogin(email: email, password: password));
          
                                
                              } else
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomWarning(
                                        text: "Fields can not be empty",
                                      );
                                    });
                            },
                            text: "Login ",
                          ),
                        ),
                      );
                    }, listener: (BuildContext context, AuthState state) {
                            if (state is LoggedIn) {
                                  NextScreen(context: context, page: HomePage());
                                }
          
                      },),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Text.rich((TextSpan(children: [
                        TextSpan(
                            text: "If you don't have an account",
                            style: Theme.of(context).textTheme.displayMedium),
                        TextSpan(
                            text: " Signup",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NextScreen(context: context, page: SignUp());
                              },
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color:  Theme.of(context).colorScheme.onBackground))
                      ]))),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
