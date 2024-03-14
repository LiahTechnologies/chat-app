import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:njadia/src/common/services/backend.dart';
// import 'package:njadia/src/common/services/face_detection.dart';
import 'package:njadia/src/common/urls.dart';

import 'package:njadia/src/utils/CustomButton.dart';

import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/features/authentication/screens/signup/widgets/imageRequirement.dart';
import 'package:njadia/src/features/authentication/screens/signup/widgets/radioWidget.dart';
import 'package:njadia/src/features/authentication/screens/signup/widgets/signupInputDetails.dart';
import 'package:country_picker/country_picker.dart';
import 'package:njadia/src/utils/customInputWidget.dart';
import 'package:njadia/src/utils/datePicker.dart';
import 'package:njadia/src/warnings/warning.dart';
import '../../../../../common/helper_function.dart';
import '../../../../../common/constants/style/appAsset.dart';
import '../../../../../utils/CustomDots.dart';
import '../../../../../utils/customButtomWithCustomICons.dart';
import '../controller/signController.dart';
import '../widgets/otp.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  Signup({
    super.key,
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final AuthService auth = AuthService();

  String finalUserOTP = "";
  SignController signUpController = Get.put(SignController());

// controllers

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  String email = '';
  String password = '';
  String confirm = '';

  // page controller
  final controller = PageController();

// Checkbox state
  bool isChecked = false;
  bool isRadioChecked = false;
  String selectedCountry = '';
  String selectedCountryCode = '';

// face detection
  bool isFaceDetectorChecking = false;
  String isSmiling = '';
  String headRotation = '';
  File? selectedCameraImage;
  File? selectedCameraImageDocs;

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
  void initState() {
    super.initState();
    _initialize();
  }

  late FaceDetector _faceDetector;
  List<Face> _faces = [];
  ImagePicker _imagePicker = ImagePicker();

  Future<void> _initialize() async {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );
  }

  Future<void> _detectFaces({required File image}) async {
    print("TRYING TO DETECT FACE");
    if (image.path.isNotEmpty) {
      final inputImage = InputImage.fromFilePath(image.path);
      try {
        final List<Face> faces = await _faceDetector.processImage(inputImage);

        if (faces.length >= 1) {
          setState(() {
            _faces = faces;
            isFaceDetected = true;
          });

          print("FACE HAS BEEN DETECTED");
        } else {
          print("FACE HAS NOT BEEN DETECTED");
        }
      } catch (e) {
        setState(() {
          isFaceDetected = false;
        });
        print("Error detecting faces: $e");
      }
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            /**
             * INPUT NUMBER
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
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
                        CustomDots(index: 3, position: 1),
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
                  CustomInputWidget(
                      borderRadius: 12,
                      marginTop: 12,
                      text: "Confirm Password",
                      onChange: (v) {
                        confirm = v;
                      }),
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
                                  controller.nextPage(
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
                        text: "Next",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text.rich((TextSpan(children: [
                      TextSpan(
                          text: "If you already have an account",
                          style: Theme.of(context).textTheme.displaySmall),
                      TextSpan(
                          text: " Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.LOGIN);
                            },
                          style: Theme.of(context).textTheme.labelSmall)
                    ]))),
                  )
                ],
              ),
            ),

            /**
             * VERIFY OTP CODE
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        CustomDots(index: 3, position: 2),
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
                      // setState(() {
                      phoneNumber.text = v;
                      // });
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
                          print("THE FINAL VERIFICATION CODE IS $finalUserOTP");
                          // authService
                          // .verifyOTP(
                          // context: context,
                          // verificationId: finalUserOTP.trim())
                          // .whenComplete(() {

                          // });

                          await BackendApi.generateOTP(
                              numbers: phoneNumber.text);

                          controller.nextPage(
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

            /**
             * VERIFY OTP CODE
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        CustomDots(index: 3, position: 2),
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
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 2,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 3,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 4,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 5,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 6,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
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
                          label: Text(
                            "Resend code",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: AppColor.greenColor),
                          )),
                      TextButton.icon(
                          onPressed: () {
                            controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xff1FAF67),
                            size: 16,
                          ),
                          label: Text(
                            "change phone number",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: AppColor.greenColor),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () async {
                          print("THE FINAL VERIFICATION CODE IS $finalUserOTP");
                          // authService
                          // .verifyOTP(
                          // context: context,
                          // verificationId: finalUserOTP.trim())
                          // .whenComplete(() {

                          // });
                          final status = await BackendApi.verifyOTP(
                              number: phoneNumber.text, Code: finalUserOTP);
                          print("THE RESPONSE VERIFY STAT $status");

                          controller.nextPage(
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

            /**
             * THIS IS THE THIRD PART
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account Creation",
                      style: Theme.of(context).textTheme.titleMedium),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 3),
                        CustomDots(index: 2, position: 3),
                        CustomDots(index: 3, position: 3),
                        CustomDots(index: 4, position: 3),
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
                  //   firstNamecontroller: firstName,
                  //   lastNamecontroller: lastName,
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
                    width: 350.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date Of Birth",
                            style: Theme.of(context).textTheme.displayMedium),
                        SizedBox(
                          width: 130.w,
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

                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      Text(
                        "I agree to the",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        " Terms of service",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        " and",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(" Privacy Policy",
                          style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () {
                          if (firstName.text.isNotEmpty ||
                              lastName.text.isNotEmpty ||
                              phoneNumber.text.isNotEmpty ||
                              dateOfBirth.text.isNotEmpty)
                            controller.nextPage(
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

            /***
             * THIS IS THE FOURTH PART
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify your identity",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 4),
                        CustomDots(index: 2, position: 4),
                        CustomDots(index: 3, position: 4),
                        CustomDots(index: 4, position: 4),
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
                    onPress: () => controller.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut),
                    text: "Take a selfie hold ID",
                    height: 50.h,
                    width: 350.w,
                    icon: !isSelfie
                        ? const Icon(
                            Icons.arrow_forward_ios_outlined,
                          )
                        : Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColor.whiteColor),
                            child: const Center(
                              child: Icon(
                                Icons.done,
                                color: AppColor.greenColor,
                              ),
                            ),
                          ),
                    image: "assets/images/camera_mask.png",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButtonWithCustomIcons(
                    onPress: () => {controller.jumpToPage(7)},
                    text: "Add a photo ID",
                    height: 50.h,
                    width: 350.w,
                    icon: !isDocument
                        ? const Icon(
                            Icons.arrow_forward_ios_outlined,
                          )
                        : Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColor.whiteColor),
                            child: const Center(
                              child: Icon(
                                Icons.done,
                                color: AppColor.greenColor,
                              ),
                            ),
                          ),
                    image: "assets/images/nid.png",
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 200.0.h),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        isActive: isSelfie == true && isDocument == true
                            ? true
                            : false,
                        onPress: () {
                          if (isSelfie == true && isDocument == true)
                            controller.jumpToPage(9);
                        },
                        text: "Continue",
                        height: 40.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /**
             * THIS IS FOR CAMERA IMAGE
             */

            Container(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 12,
                        ),
                        onPressed: () => controller.previousPage(
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
                        style: AppFonts.defaultBlack600,
                      ),
                    ),
                  ),
                  const ImageRequirementWidget(text: "Clearly show your face"),
                  const ImageRequirementWidget(
                      text: "Keep your phone vertical"),
                  const ImageRequirementWidget(
                      text: "Make sure you're well lit"),
                  const ImageRequirementWidget(
                      text: "Be sure that your ID is visible"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => {
                          openCamera("Camera", "selfie"),
                          Future.delayed(const Duration(seconds: 5), () {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          })
                        },
                        child: Text("Open the camera",
                            style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
             * THIS IS FOR SHOWING THE SELFIE IMAGE
             */

            Container(
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
                        label: Text(
                          "Retake",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: AppColor.greenColor),
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageRequirementWidget(
                              show: true, text: "Make sure your ID is visible"),
                          ImageRequirementWidget(
                              show: true, text: "Make sure it's bright enough"),
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
                          EdgeInsets.only(left: 30.w, top: 90.h, right: 20.w),
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => {
                          controller.jumpToPage(4),
                        },
                        child: Text("Continue", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
             * 
             * this is for selection of 
             * id,or password
             */

            Container(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 12,
                        ),
                        onPressed: () => controller.jumpToPage(4),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    height: 280.h,
                    child: Card(
                      color: Colors.white.withOpacity(0.7),
                      child: Padding(
                        padding: EdgeInsets.all(18.0.w),
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
                                          color: AppColor.greenColor)),
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
                                  setState(() {
                                    selectedDocumentType = 0;
                                  });
                                },
                              ),
                              RadioWidget(
                                text: "Passport",
                                index: 1,
                                active: selectedDocumentType,
                                onTap: (v) {
                                  setState(() {
                                    selectedDocumentType = 1;
                                  });
                                },
                              ),
                              RadioWidget(
                                text: "Driving Licence",
                                index: 2,
                                active: selectedDocumentType,
                                onTap: (v) {
                                  setState(() {
                                    selectedDocumentType = v;
                                  });
                                },
                              ),
                            ]),
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
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => {
                          openCamera("Camera", "id"),
                          Future.delayed(Duration(seconds: 2), () {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          }),
                        },
                        child: Text("Continue", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
         * SHOW DOCUMENT TYPE
         */

            Container(
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
                        label: Text(
                          "Retake",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: AppColor.greenColor),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 30.w, top: 60.h, right: 10.h),
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => {controller.jumpToPage(4)},
                        child: Text("Continue", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //  THIS IS THE FINISHING WIDGET

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Finishing ...", style: AppFonts.heading3),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text("Syncing credentials ...", style: AppFonts.defaultFonts),
                  SizedBox(
                    height: 200.h,
                  ),
                  Center(
                    child: Image.asset(AppImages.LOADING_ICON),
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          onPress: () => {
                                BackendApi.registration(
                                        firstName: firstName.text,
                                        lastName: lastName.text,
                                        email: email,
                                        password: password,
                                        phone_number: phoneNumber.text,
                                        date_of_birth: dateOfBirth.text,
                                        image: selectedCameraImage!,
                                        imageDocs: selectedCameraImageDocs!)
                                    .then((value) {
                                  if (value == true)
                                    Get.toNamed(AppRoutes.HOMEpAGE);
                                })
                              },
                          text: "Finish"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  signUpFields(name, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.h),
          child: Text(
            "$name",
            style: AppFonts.defaultFonts,
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: AppColor.greenColor,
                border: Border.all(color: AppColor.greenColor)),
            child: TextField(
                controller: controller,
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

      type == "selfie" ? isSelfie = true : isDocument = true;
    });

    if (type == "selfie") _detectFaces(image: cameraImage);
  }

  // Future<bool> register() async {
  //   bool isUserExist = false;
  //   setState(() {
  //     // _isloading = true;
  //   });

  //   await DatabaseServices().checkIfUserExist(email).then((value) {
  //     setState(() {
  //       isUserExist = value;
  //     });
  //   });

  //   if (isUserExist) {
  //     final isSignup = await AuthController.registerWithEmailAndPassword(
  //       firstName: firstName.text,
  //       lastName: lastName.text,
  //       email: email,
  //       phoneNumber: phoneNumber.text,
  //       dateOfBirth: dateOfBirth.text,
  //       password: password.removeAllWhitespace,
  //     );

  //     if (isSignup!) {
  //       showSnackMessage(context, Colors.green, "signup successful");

  //       return true;
  //     } else {
  //       showSnackMessage(context, Colors.red, "signup error");
  //       setState(() {
  //         // _isloading = false;
  //       });
  //       return false;
  //     }
  //     return true;
  //   } else {
  //     showSnackMessage(context, Colors.red, "User already exist");
  //     Get.toNamed(AppRoutes.LOGIN);
  //     return false;
  //   }
  // }
}
