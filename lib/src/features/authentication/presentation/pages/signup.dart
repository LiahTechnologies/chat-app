import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';

import 'package:njadia/src/features/authentication/domain/entities/user-entity.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_event.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_state.dart';
import 'package:njadia/src/features/authentication/presentation/pages/login.dart';
import 'package:njadia/src/features/home/presentation/view/home.dart';

import 'package:njadia/src/utils/CustomButton.dart';

import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/features/authentication/presentation/widgets/imageRequirement.dart';
import 'package:njadia/src/features/authentication/presentation/widgets/radioWidget.dart';
import 'package:njadia/src/utils/customInputWidget.dart';
import 'package:njadia/src/utils/datePicker.dart';
import 'package:njadia/src/utils/device-height-and-width.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/warning.dart';
import '../../../../core/common/constants/style/appAsset.dart';
import '../../../../utils/CustomDots.dart';
import '../../../../utils/customButtomWithCustomICons.dart';
import '../widgets/otp.dart';

class SignUp extends StatefulWidget {
  SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final AuthService auth = AuthService();

  String finalUserOTP = "";

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  String email = '';
  String password = '';
  String confirm = '';

  // page controller
  final pagecontroller = PageController();

// Checkbox state
  bool isChecked = false;
  bool isRadioChecked = false;
  String selectedCountry = '';
  String selectedCountryCode = '';

// face detection
  bool isFaceDetectorChecking = false;
  String isSmiling = '';
  String headRotation = '';
  File? selectedCameraImage =File("");
  File? selectedCameraImageDocs =File("");

  // booleans

  bool isSelfie = false;
  bool isDocument = false;
  bool isFaceDetected = false;

// SELECT GENDER
  String selectedGender = "None";

// seleceted Document type

  int selectedDocumentType = -1;

  // CameraController? cameraController;

  // late final AuthController = Get.put(AuthenticationServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
          
          return PageView(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            children: [
              /**
                 * INPUT NUMBER
                 */
          
              Container(
                margin: EdgeInsets.only(
                    top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                       
                            
                      Text("Account Creation",
                          style: Theme.of(context).textTheme.titleMedium),
                      Container(
                        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: const Row(
                          children: [
                            CustomDots(index: 1, position: 1),
                            CustomDots(index: 2, position: 1),
                            CustomDots(index: 3, position: 1),
                            CustomDots(index: 4, position: 1),
                            CustomDots(index: 5, position: 1),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Enter your ",
                              style: Theme.of(context).textTheme.displayMedium),
                          TextSpan(
                              text: "Email & Password",
                              style: Theme.of(context).textTheme.displayMedium),
                          TextSpan(
                              text: " Below.",
                              style: Theme.of(context).textTheme.displayMedium),
                        ])),
                      ),
                      Text(
                          "We will send  a 6 digit code to verify your phone  number",
                          style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomInputWidget(
                          borderRadius: 12,
                          marginTop: 12,
                          text: "Email",
                          onChange: (v) {
                            email = v;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomInputWidget(
                          borderRadius: 12,
                          marginTop: 12,
                          text: "Password",
                          onChange: (v) {
                            password = v;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomInputWidget(
                          borderRadius: 12,
                          marginTop: 12,
                          text: "Confirm Password",
                          onChange: (v) {
                            confirm = v;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            onPress: () => {
                              // AuthController.registerWithPhoneNumber("+237", context),
                            
                              if (email.isNotEmpty ||
                                  password.isNotEmpty ||
                                  confirm.isNotEmpty)
                                {
                                  if (email.contains("@") && email.contains("."))
                                    if (password == confirm)
                                      pagecontroller.nextPage(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut)
                                    else
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomWarning(
                                              text: "Password must match",
                                            );
                                          })
                                  else
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomWarning(
                                            text: "Enter a valid email",
                                          );
                                        })
                                }
                              else
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomWarning(
                                        text: "fields can not be empty",
                                      );
                                    })
                            },
                            text: "Continue",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text.rich((TextSpan(children: [
                          TextSpan(
                              text: "If you already have an account",
                              style: Theme.of(context).textTheme.displayMedium),
                          TextSpan(
                              text: " Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  NextScreen(
                                      context: context, page: LoginScreen());
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onBackground))
                        ]))),
                      )
                    ],
                  ),
                ),
              ),
          
              /**
                 * VERIFY OTP CODE
                 */
          
              Container(
                margin: EdgeInsets.only(
                    top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                        Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pagecontroller.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                            
                      SizedBox(height: 5,),
                            
                      Text(
                        "Account Creation",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: const Row(
                          children: [
                            CustomDots(index: 1, position: 2),
                            CustomDots(index: 2, position: 2),
                            CustomDots(index: 3, position: 2),
                            CustomDots(index: 4, position: 2),
                            CustomDots(index: 5, position: 2),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "Enter your phone number. This number must be your mobile money number.",
                              style: Theme.of(context).textTheme.displayMedium),
                          TextSpan(
                            text: "\n\nA verification code will be ",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          TextSpan(
                              text: " sent to your phone.",
                              style: Theme.of(context).textTheme.displayMedium),
                        ])),
                      ),
                      CustomInputWidget(
                        onChange: (v) {
                          phoneNumber.text = v;
                        },
                        borderRadius: 12,
                        hint: "Enter your phone number 6733445566",
                      ),
                      /*
                      
                        */
                      Padding(
                        padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            onPress: () async {
                              print("THE FINAL VERIFICATION CODE IS ");
                            
                              context
                                  .read<AuthBloc>()
                                  .add(OnOTPGeneration(number: phoneNumber.text));
                            
                              pagecontroller.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut);
                            },
                            text: "Continue",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              /**
                 * VERIFY OTP CODE
                 */
          
              Container(
                margin: EdgeInsets.only(
                    top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pagecontroller.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                            
                      SizedBox(height: 5,),
                            
                      Text(
                        "Account Creation",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: const Row(
                          children: [
                            CustomDots(index: 1, position: 3),
                            CustomDots(index: 2, position: 3),
                            CustomDots(index: 3, position: 3),
                            CustomDots(index: 4, position: 3),
                            CustomDots(index: 5, position: 3),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Enter the  4 digit  ",
                              style: Theme.of(context).textTheme.displayMedium),
                          TextSpan(
                            text: "verification code",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          TextSpan(
                              text: " sent to your phone.",
                              style: Theme.of(context).textTheme.displayMedium),
                        ])),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0.h, bottom: 18.h),
                        child: Text(
                          "Verification code",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OTPInput(
                            index: 1,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),
                          OTPInput(
                            index: 2,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),
                          OTPInput(
                            index: 3,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),
                          OTPInput(
                            index: 4,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),
                          /*  OTPInput(
                            index: 5,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),
                          OTPInput(
                            index: 6,
                            userOTP: (value) {
                              finalUserOTP = finalUserOTP + "" + value;
                            },
                          ),*/
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                // authService.registerWithPhoneNumber(
                                // "+237", context);
                              },
                              icon: const Icon(
                                Icons.replay_outlined,
                                color: Color(0xff1FAF67),
                                size: 16,
                              ),
                              label: Text("Resend code",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!.copyWith(fontSize: 12))),
                          TextButton.icon(
                              onPressed: () {
                                pagecontroller.previousPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xff1FAF67),
                                size: 16,
                              ),
                              label: Text("Change phone number",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontSize: 12)))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            onPress: () async {
                              context.read<AuthBloc>().add(OnOTPVerification(
                                  number: phoneNumber.text,
                                  OTPCode: finalUserOTP.trim()));
                            
                              print("THE CURRENT STATE IS ${state}");
                            
                              // if (state is OTPCodeVerified)
                            
                              pagecontroller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            text: "Continue",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              /**
                 * THIS IS THE THIRD PART
                 */
          
              Container(
                margin: EdgeInsets.only(
                    top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                        Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pagecontroller.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                            
                      SizedBox(height: 5,),
                            
                      Text("Account Creation",
                          style: Theme.of(context).textTheme.titleMedium),
                      Container(
                        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: const Row(
                          children: [
                            CustomDots(index: 1, position: 4),
                            CustomDots(index: 2, position: 4),
                            CustomDots(index: 3, position: 4),
                            CustomDots(index: 4, position: 4),
                            CustomDots(index: 5, position: 4),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Now lets get to know more about you!",
                              style: Theme.of(context).textTheme.displayMedium),
                        ])),
                      ),
                      Container(
                        height: 100.h,
                        width: double.infinity,
                        child: Stack(children: [
                          Positioned(
                            child: Container(
                              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 50.h,
                                  backgroundImage: const AssetImage(
                                      "assets/images/Ellipse 34.png"),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //     top: 90.h,
                          //     left: 60.w,
                          //     child: Image.asset("assets/images/upload.png"))
                        ]),
                      ),
                      // SignUpDetails(
                      //   firstNamepagecontroller: firstName,
                      //   lastNamepagecontroller: lastName,
                      // ),
                            
                      CustomInputWidget(
                          borderRadius: 12,
                          marginTop: 12,
                          text: "First Name",
                          onChange: (v) {
                            // setState(() {
                            firstName.text = v;
                            print("THE FIRST NAME IS ${firstName.text}");
                            // });
                          }),
                            
                      CustomInputWidget(
                          borderRadius: 12,
                          marginTop: 12,
                          text: "Last Name",
                          onChange: (v) {
                            // setState(() {
                            lastName.text = v;
                            
                            print("THE LAST NAME IS ${lastName.text}");
                            // });
                          }),
                            
                      Container(
                        width: deviceWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date Of Birth",
                                style: Theme.of(context).textTheme.displayMedium),
                            SizedBox(
                              width: deviceWidth(context)/2.5,
                              child: TextField(
                                controller: dateOfBirth,
                                readOnly: true,
                                onTap: () {
                                  customDatePicker(context).then((value) {
                                    if (value != null)
                                      dateOfBirth.text =
                                          value!.toString().split(" ")[0];
                                  });
                                },
                                decoration: const InputDecoration(
                                    // border: InputBorder.none,
                                    prefixIcon: Icon(Icons.calendar_month)),
                              ),
                            ),
                          ],
                        ),
                      ),
                            
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                // controller.isChecked.value = value!;
                              }),
                          Text(
                            "I agree to the",
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12),
                          ),
                          Text(
                            " Terms of service",
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12),
                          ),
                          Text(
                            " and",
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12),
                          ),
                          Text(" Privacy Policy",
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, top: 20.0.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            onPress: () {
                              if (firstName.text.isNotEmpty ||
                                  lastName.text.isNotEmpty ||
                                  phoneNumber.text.isNotEmpty ||
                                  dateOfBirth.text.isNotEmpty)
                                pagecontroller.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              else
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomWarning(
                                        text: "Fields can not be empty",
                                      );
                                    });
                            },
                            text: "Continue",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              /***
                 * THIS IS THE FOURTH PART
                 */
          
              Container(
                margin: EdgeInsets.only(
                    top: 5.h, left: 12.w, right: 12.w, bottom: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pagecontroller.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                            
                      SizedBox(height: 5,),
                      Text(
                        "Verify your identity",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: const Row(
                          children: [
                            CustomDots(index: 1, position: 5),
                            CustomDots(index: 2, position: 5),
                            CustomDots(index: 3, position: 5),
                            CustomDots(index: 4, position: 5),
                            CustomDots(index: 5, position: 5),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "Please match you face with a supported \ndocument in order to be part of Njaida group",
                              style: Theme.of(context).textTheme.displayMedium),
                        ])),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      CustomButtonWithCustomIcons(
                        onPress: () => pagecontroller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        text: "Take a selfie hold ID",
                        height: 50.h,
                        width: 350.w,
                        icon: !isSelfie
                            ? Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 18,
                              )
                            : Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                        image: "assets/images/camera_mask.png",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButtonWithCustomIcons(
                        onPress: () => {pagecontroller.jumpToPage(7)},
                        text: "Add a photo ID",
                        height: 50.h,
                        width: 350.w,
                        icon: !isDocument
                            ? const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 18,
                              )
                            : Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                        image: "assets/images/nid.png",
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.0, top: 200.0.h),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CustomButton(
                            isActive: isSelfie == true && isDocument == true
                                ? true
                                : false,
                            onPress: () {
                              // if (isSelfie == true && isDocument == true)
                                pagecontroller.jumpToPage(9);
                            },
                            text: "Continue",
                            height: 40.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              /**
                 * THIS IS FOR CAMERA IMAGE
                 */
          
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 12,
                            ),
                            onPressed: () => pagecontroller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut),
                          )),
                      Image.asset("assets/images/img_frame.png"),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 18.0.h, left: 35.w),
                          child: Text(
                            "Please take a portrait selfie whilst\nholding the ID card",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                      const ImageRequirementWidget(
                          text: "Clearly show your face"),
                      const ImageRequirementWidget(
                          text: "Keep your phone vertical"),
                      const ImageRequirementWidget(
                          text: "Make sure you're well lit"),
                      const ImageRequirementWidget(
                          text: "Be sure that your ID is visible"),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                        return Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 30.w, top: 10.h),
                            width: 150.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightButtonColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: MaterialButton(
                              onPressed: ()async {
                                openCamera("Camera", "selfie");
                                Future.delayed(const Duration(seconds: 5), () {
                                  pagecontroller.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                });
                              },
                              child: Text("Open the camera",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.white,fontSize: 12)),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
          
              /**
                 * THIS IS FOR SHOWING THE SELFIE IMAGE
                 */
          
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 20.h, bottom: 0.h),
                          height: 200.h,
                          width: 420.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: selectedCameraImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      // selectedCameraImageDocs!,
                                      selectedCameraImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(""),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                            onPressed: () {
                              openCamera("Camera", "id");
                            },
                            icon: const Icon(
                              Icons.replay_outlined,
                              color: Color(0xff1FAF67),
                              size: 16,
                            ),
                            label: Text("Retake",
                                style:
                                    Theme.of(context).textTheme.displayMedium!)),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10.w, top: 10.h),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageRequirementWidget(
                                  show: true,
                                  text: "Make sure your ID is visible"),
                              ImageRequirementWidget(
                                  show: true,
                                  text: "Make sure it's bright enough"),
                              ImageRequirementWidget(
                                  show: true,
                                  text: "Make sure your face is showing"),
                            ],
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 30.w, top: 90.h, right: 10.w,bottom: 10),
                          width: 150.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightButtonColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                            onPressed: () => {
                              pagecontroller.jumpToPage(4),
                            },
                            child: Text("Continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.white,fontSize: 12)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          
              /**
                 * 
                 * this is for selection of 
                 * id,or password
                 */
          
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon:const Icon(
                              Icons.arrow_back_ios_new,
                              size: 12,
                            ),
                            onPressed: () => pagecontroller.jumpToPage(4),
                          )),
                      Container(
                        margin:
                            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                        height: 280.h,
                        child: Card(
                          color: Colors.white.withOpacity(0.7),
                          child: Padding(
                            padding: EdgeInsets.all(18.0.w),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Please upload a valid ID",
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 10.0),
                                      child: Text("Issuing country",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                    ),
                                    Container(
                                        height: 40.h,
                                        width: 190.w,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color!)),
                                        child: Text("Cameroon",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 10.0),
                                      child: Text("Document type:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                    ),
                                    RadioWidget(
                                      text: "ID Card",
                                      index: 0,
                                      active: selectedDocumentType,
                                      onTap: (v) {
                                        // controller. selectedDocumentType.value = 0;
                                      },
                                    ),
                                    RadioWidget(
                                      text: "Passport",
                                      index: 1,
                                      active: selectedDocumentType,
                                      onTap: (v) {
                                        //  controller. selectedDocumentType.value = 1;
                                      },
                                    ),
                                    RadioWidget(
                                      text: "Driving Licence",
                                      index: 2,
                                      active: selectedDocumentType,
                                      onTap: (v) {
                                        //  controller. selectedDocumentType.value = 2;
                                      },
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 30.w, top: 40.h),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageRequirementWidget(
                                  left: 0, text: "Try to minimize glair "),
                              ImageRequirementWidget(
                                  left: 0, text: "Make sure it's well lit"),
                              ImageRequirementWidget(
                                  left: 0, text: "Make sure it's sharp"),
                            ],
                          )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 30.0.w, top: 30.h, bottom: 10.h),
                            child: Text("Retake photo",
                                style: Theme.of(context).textTheme.displayMedium),
                          )),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30.w, top: 10.h,bottom: 10),
                          width: 150.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightButtonColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                            onPressed: () => {
                              openCamera("Camera", "id"),

                              Future.delayed(Duration(seconds: 2), () {
                                pagecontroller.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              }),
                            },
                            child: Text("Continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          
              /**
             * SHOW DOCUMENT TYPE
             */
          
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 10.h, bottom: 0.h),
                          height: 250.h,
                          width: 420.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: selectedCameraImageDocs != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      selectedCameraImageDocs!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(""),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                            onPressed: () {
                              openCamera("Gallery", 'id');
                            },
                            icon: const Icon(
                              Icons.replay_outlined,
                              color: Color(0xff1FAF67),
                              size: 16,
                            ),
                            label: Text("Retake",
                                style:
                                    Theme.of(context).textTheme.displayMedium!)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 30.w, top: 60.h, right: 10.h,bottom: 10),
                          width: 150.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightButtonColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: MaterialButton(
                            onPressed: () => {pagecontroller.jumpToPage(4)},
                            child: Text("Continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          
              //  THIS IS THE FINISHING WIDGET
          
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Finishing ...",
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text("Syncing credentials ...",
                          style: Theme.of(context).textTheme.displayMedium),
                     
                     deviceOrientation(context)==Orientation.portrait?
                      SizedBox(
                        height: deviceHeight(context)/5,
                      ): SizedBox(height: deviceHeight(context)/15,),
                      Center(
                        child: Image.asset(AppImages.LOADING_ICON),
                      ),
                   deviceOrientation(context)==Orientation.portrait?

                      SizedBox(
                        height: deviceHeight(context)/5,
                      ): SizedBox(height:deviceHeight(context)/10,),
                      Align(
                          alignment: 
                   deviceOrientation(context)==Orientation.portrait? Alignment.bottomCenter:Alignment.bottomRight,
                          child: CustomButton(
                              onPress: () => {
                                    // BackendApi.registration(
                                    //         firstName: firstName.text,
                                    //         lastName: lastName.text,
                                    //         email: email,
                                    //         password: password,
                                    //         phone_number: phoneNumber.text,
                                    //         date_of_birth: dateOfBirth.text,
                                    //         image: selectedCameraImage!,
                                    //         imageDocs: selectedCameraImageDocs!)
                                    //     .then((value) {
                                    //   if (value == true)
                                    //     Get.toNamed(AppRoutes.HOMEpAGE);
                                    // })
                            
                                    context.read<AuthBloc>().add(OnSignUp(
                                          selfie:selectedCameraImage !,
                                          docs: selectedCameraImageDocs!,
                                        userEntity: UserEntity(
                                            firstName: firstName.text,
                                            lastName: lastName.text,
                                            email: email,
                                            password: password,
                                            dob: dateOfBirth.text,
                                            tel: phoneNumber.text,
                                            selfie: "selectedCameraImage!",
                                            docs: "selectedCameraImageDocs!"
                                            
                                            ))),
                            
                                   
                                  },
                              text: "Finish"))
                    ],
                  ),
                ),
              )
            ],
          );
        }, listener: (BuildContext context, AuthState state) { 
                 if (state is SignUpSuccessful) {
                   NextScreen(
                                        context: context, page:const HomePage());
                 }

                 if(state is AuthFailure){
                  showDialog(context: context, builder: (context)=>ScaffoldMessenger(child: SnackBar(backgroundColor: Colors.red,content: Text("${state.message}"))));
                 }
         },),
      ),
    );
  }

  signUpFields(name, pagecontroller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.h),
          child: Text(
            "$name",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: AppColor.greenColor,
                border: Border.all(color: Theme.of(context).iconTheme.color!)),
            child: TextField(
                // controller: pagecontroller,
                decoration: InputDecoration(
              border: InputBorder.none,
            ))),
      ],
    );
  }

  Future<void> openCamera(method, type) async {
    final ImagePicker picker = ImagePicker();
    var source;
    method == "Camera"
        ? source = ImageSource.camera
        : source = ImageSource.gallery;

    final XFile? image = await picker.pickImage(source: source);

    File cameraImage = File(image!.path);

    setState(() {
      type == "selfie"
          ? selectedCameraImage = cameraImage
          : selectedCameraImageDocs = cameraImage;
    });

    type == "selfie" ? isSelfie = true : isDocument = true;

    // if (type == "selfie") _detectFaces(image: cameraImage);
  }
}
