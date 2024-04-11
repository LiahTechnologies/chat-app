import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';


// enum  AppTheme{

// };
class AppTheme {
  static final lightTheme = ThemeData(

    brightness: Brightness.light,

    colorScheme:  ColorScheme.light(
        background: Colors.grey[300]!,
        primary: Colors.grey[300]!,
        secondary: Colors.grey[400]!,
         tertiary: AppColor.purpleColor

    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.blackColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.blackColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.blackColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.blackColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.blackColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.purpleColor),
      labelMedium: GoogleFonts.dmSans(fontSize: 11,color: AppColor.whiteColor),

    ),
  appBarTheme:const  AppBarTheme(
      backgroundColor: AppColor.transparent,
      elevation: 0
      ) ,

  iconTheme:const IconThemeData(color: AppColor.blackColor),
      inputDecorationTheme:const  InputDecorationTheme(
        iconColor:AppColor.blackColor 
      ),

// color for cards

  cardTheme: CardTheme(
    color: AppColor.whiteColor
  )

    
  );

   static final darkTheme = ThemeData(

    brightness:Brightness.dark,
    colorScheme:  ColorScheme.dark(
      background: Color.fromARGB(248, 28, 29, 28),
      primary:    AppColor.primaryColor,
      secondary: AppColor.secondary,
      tertiary: AppColor.purpleColor
    ),

  
    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.whiteColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.grayColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.whiteColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.whiteColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.greenColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.purpleColor),
      labelMedium: GoogleFonts.dmSans(fontSize: 11,color: AppColor.greenColor),

    ),
    appBarTheme:const AppBarTheme(
        backgroundColor: AppColor.blackColor,
        elevation: 0
        ),



    buttonTheme: const ButtonThemeData(buttonColor: AppColor.purpleColor),
      iconTheme:const  IconThemeData(
        color: AppColor.whiteColor,
        
      ),


  inputDecorationTheme:const InputDecorationTheme(
    iconColor:AppColor.grayColor 
  ),


// color for cards

  cardTheme: CardTheme(
    color: AppColor.cardColor
  )

// typography: Typography(black: TextTheme())
    // buttonTheme: ButtonTheme(child: ,)
  );

  
}
