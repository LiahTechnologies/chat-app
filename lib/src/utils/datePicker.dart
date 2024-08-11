import 'package:flutter/material.dart';

Future<DateTime?> customDatePicker(BuildContext context) async {
  DateTime? date = await showDatePicker(
      builder: (context, child)=> Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.yellow, // header background color
              onPrimary: Colors.black, // header text color
              // onSurface: Colors.green, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
         
      
      ),
      context: context,initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2400));
      
  return date;
}
