import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/common/helper_function.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/features/authentication/presentation/pages/signup.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/utils/opneCamera.dart';
import 'package:njadia/src/utils/theme/theme_bloc.dart';
import 'package:njadia/src/utils/theme/theme_event.dart';
import 'package:njadia/src/warnings/customDialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late File newProfileImage;

  String userEmail = "";
  String userName = "";
  @override
  void initState() {
    // TODO: implement initState

    HelperFunction.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
      print(" THE CURRENT USER NAME IS : $userName");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          // Switch(value: context.read<ThemeBloc>().state==ThemeMode.dark, onChanged: (value){
          //   context
          //                 .read()<ThemeBloc>()
          //                 .add(OnThemeChange(value));

          // }),
          !(context.read<ThemeBloc>().state == ThemeMode.dark)
              ? BlocBuilder<ThemeBloc, ThemeMode>(builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.sunny,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {

                    
                      context.read<ThemeBloc>().add(OnThemeChange(
                          (state == ThemeMode.light)));

                      

                     
                    },
                  );
                })
              : BlocBuilder<ThemeBloc,ThemeMode>(
                builder: (context,state) {
                  return IconButton(
                      onPressed: () {
                      context.read<ThemeBloc>().add(OnThemeChange(
                          (state == ThemeMode.light)));

                      },
                      icon: Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                      ));
                }
              ),
          IconButton(
              onPressed: () async {
                NextScreen(context: context, page: SignUp());
                // databaseController.login();

                showSnackMessage(context, Colors.green, "LogOut successful");
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).iconTheme.color,
              )),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                        child: Image.asset(
                      AppImages.PERSON,
                      width: 120,
                    )),
                  ),
                  Positioned(
                    top: 20.h,
                    left: 96.w,
                    child: InkWell(
                      onTap: () => openCamera(method: "gallery").then((value) {
                        // setState(() {
                        //   newProfileImage = value;
                        // });
                      }),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.whiteColor),
                        child: Container(
                            height: 22.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.greenColor),
                            child: Icon(
                              Icons.edit,
                              color: AppColor.whiteColor,
                              size: 15,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "$userName",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            Text("${userEmail}",
                style: Theme.of(context).textTheme.displayMedium),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileText(number: 23, text: "Njangi groups"),
                Container(
                  height: 40,
                  width: 2,
                  color: AppColor.greenColor,
                ),
                profileText(number: 23, text: "Age"),
                Container(
                  height: 40,
                  width: 2,
                  color: AppColor.greenColor,
                ),
                Stack(
                  children: [
                    profileText(number: 672973390, text: "Telephone"),
                    Positioned(
                      top: 20.h,
                      left: 79.w,
                      child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => const CustomDailog());
                          },
                          child: Icon(
                            Icons.edit,
                            color: AppColor.greenColor,
                            size: 15,
                          )

                          /* Container(
                          padding:
                              EdgeInsets.all(1),
                          // height: 16,
                          // width: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.whiteColor),
                          child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.greenColor),
                              child: 
                              Icon(
                                Icons.edit,
                                color: AppColor.whiteColor,
                                size: 10,
                              )
                              ),
                        ),*/
                          ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [Text("")],
                  ),
                )
              ],
            ),
            customKeyValue(text: "Current MTN Account Balance:", value: 23),
            customKeyValue(text: "Current Orange Account Balance:", value: 33),
          ]),
    );
  }

  profileText({number, text}) {
    return Column(
      children: [
        Text(
          "$number",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
        ),
        Text(
          "$text",
          style: Theme.of(context).textTheme.displayMedium,
        )
      ],
    );
  }

  customKeyValue({text, value}) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "$value",
              style: Theme.of(context).textTheme.displayMedium,
            )
          ]),
        ),
      ),
    );
  }
}
