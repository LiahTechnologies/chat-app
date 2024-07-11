import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';


// enum  AppTheme{

// };
class AppTheme {

  static final lightTheme = ThemeData(

    brightness: Brightness.light,
    colorScheme:  ColorScheme.light(
        background: AppColor.lightModePrimary,
        primary: AppColor.lightModePrimary,
        secondary: AppColor.lightModePrimary,
         tertiary: Colors.grey[400]!,
         onPrimary: Colors.black,
         onBackground: AppColor.lightButtonColor

         
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColor.LightAppBarColor,
       shadowColor: Colors.white
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 18,color: AppColor.lightTextColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 13,color: AppColor.lightTextColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 16,color:AppColor.lightTextColor),
      titleLarge: GoogleFonts.dmSans(fontWeight:FontWeight.bold,fontSize: 24,color: AppColor.lightHeadColor,),
      titleMedium: GoogleFonts.dmSans(fontWeight:FontWeight.bold,fontSize: 20,color: AppColor.lightHeadColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.lightTextColor),
      labelMedium: GoogleFonts.dmSans(fontSize: 11,color: AppColor.lightTextColor),

    ),



  appBarTheme:  AppBarTheme(

      titleTextStyle: GoogleFonts.dmSans(fontSize: 20,color: Colors.white), 
      backgroundColor: AppColor.LightAppBarColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white
      )
      ) ,

  iconTheme: IconThemeData(
    color: AppColor.lightIconColor),
  
      inputDecorationTheme:  InputDecorationTheme(
        iconColor:AppColor.darkIconColor 
      ),

     buttonTheme: ButtonThemeData(
      
     ),

// color for cards
  cardTheme: CardTheme(
    color: AppColor.lightIconColor
  )   
  );




/*************DARK MODE*****************/


   static final darkTheme = ThemeData(

    brightness:Brightness.dark,
    colorScheme:  ColorScheme.dark(
      background: AppColor.darkModePrimary,
      primary:    AppColor.darkModePrimary,
      secondary: AppColor.greenColor.withOpacity(0.6),
      tertiary: Colors.black38,
      onPrimary: Colors.white,
      onBackground: Colors.teal
    ),

  
    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.darkTextColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 16,color: AppColor.darkTextColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 14,color:AppColor.darkTextColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.darkHeadingColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.darkHeadingColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 14,color: AppColor.darkTextColor),
      labelMedium: GoogleFonts.dmSans(fontSize: 14,color: AppColor.darkTextColor),

    ),

    appBarTheme: AppBarTheme(
        iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.darkAppBarColor,
        titleTextStyle: GoogleFonts.dmSans(fontSize: 20,color: AppColor.darkTextColor), 
        elevation: 0
        ),



    buttonTheme:  ButtonThemeData(buttonColor: AppColor.darkButtonColor),
      iconTheme:  IconThemeData(
        color: AppColor.darkIconColor,
        
      ),


  inputDecorationTheme: InputDecorationTheme(
    iconColor:AppColor.darkIconColor 
  ),

     bottomAppBarTheme: BottomAppBarTheme(
      color: AppColor.darkAppBarColor,
      shadowColor: Colors.white
      
    ),


// color for cards

  cardTheme: CardTheme(
    color: AppColor.darkIconColor
  )


  );

  
}
