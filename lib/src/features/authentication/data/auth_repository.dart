import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/authentication/data/model/userModel.dart';
import 'package:njadia/src/features/authentication/screens/signup/views/signup.dart';

import '../../../common/helper_function.dart';
import '../../../common/services/firebase_messaging.dart';

/// ---README(Docs[6]) --Bindings

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  // SignController signUpController = Get.put(SignController());
// login

  var OTP = '';
  String _uid = '';
  String get uid => _uid;
  String verificationCode = '';

  Future signinUser({required password, required email}) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {

        // await userCollection
        //     .where("email", isEqualTo: email).

        //     .then((value) {
        //   final userData = value.docs.first.data();
        //   userData!.;
        //   // UserEntity.fromjson(jsonDecode());
        // });

         await HelperFunction.saveUserID(user.uid);
          await HelperFunction.saveUserID(user.displayName!);
        await HelperFunction.saveUserLoggInState(true);
        await HelperFunction.saveUserEmail(email);
        await HelperFunction.saveUserLoggInState(true);
        return true;
      }
    } catch (e) {}
  }

// phone number signup

  Future registerWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth
                .signInWithCredential(credential)
                .then((value) => {print("THIS IS THE CODE $value")});
          },
          verificationFailed: (e) {
            if (e.code == 'invalid-phone-number') {
              showSnackMessage(context, const Color.fromARGB(255, 10, 7, 7),
                  "Inalid phone number");
            } else {
              print("THIS  IS THE VERIFICATION CODE $e");

              showSnackMessage(context, Colors.green, "successful");
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            // this.OTP = verificationId;
            // Navigator.push(context, route)
            verificationCode = verificationId;
            // signUpController.OTPcode = RxString(verificationId);
          },
          codeAutoRetrievalTimeout: (verificationId) {
            this.OTP = verificationId;
          });
    } catch (e) {}
  }

  // OTP  verification

  Future<void> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      Function? onSubmit}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: verificationId);
      User user = (await firebaseAuth.signInWithCredential(credential)).user!;

      if (user != null) {
        _uid = user.uid;
        onSubmit!();
      }
    } on FirebaseAuthException catch (e) {}
  }

  /// REGISTER USER WITH EMAIL AND PASSWORD

  Future<bool?> registerUserWithEmailAndPassword(
      {required String password,
      required String email,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      dateOBirth}) async {
    try {
      
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user.uid != null) {
        user.updateDisplayName(firstName+" "+ lastName);
        await DatabaseServices(uid: user.uid).updateUserData(
            firstName: firstName,
            email: email,
            lastName: lastName,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOBirth);
            
        HelperFunction.saveUserID(user.uid);
        await HelperFunction.saveUserName(firstName+" "+ lastName);
        await HelperFunction.saveUserEmail(email);
        await HelperFunction.saveUserLoggInState(true);

        return true;
      } else
        return false;
    } on FirebaseAuthException catch (e) {
      

      return false;
    }
  }

  /// EMAIL VERIFICATON

  Future<void> emailverification() async {
    try {
      await firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

// LOGIN USER

  login() async {
    await HelperFunction.saveUserEmail("");
    await HelperFunction.saveUserLoggInState(false);
    await HelperFunction.saveUserName("");
    await firebaseAuth.signOut();
  }

  logout() {}
}
