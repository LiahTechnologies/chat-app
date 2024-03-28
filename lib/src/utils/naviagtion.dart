import 'package:flutter/material.dart';

NextScreen({required BuildContext context, required Widget page}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

BackScreen({required BuildContext context}) => Navigator.pop(context);

SplashScreenNavigator({required BuildContext context, required Widget page}) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
