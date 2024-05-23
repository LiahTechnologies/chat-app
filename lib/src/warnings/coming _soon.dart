import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:njadia/src/utils/naviagtion.dart';

class ComiingSoon extends StatelessWidget {
  const ComiingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(alignment: Alignment.center, children: [
    
      Align(
        alignment: Alignment.topRight,
        child: IconButton(icon:const Icon(Icons.close),onPressed: ()=>BackScreen(context: context)),
      ),
          Center(
    child: Text(
      "Coming Soon !",
      style:Theme.of(context).textTheme.bodyLarge
    ),
          ),
    
           Center(
    child: Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.0,horizontal:10.w ),
      child: Text(
        "This feature will be added in the upcoming version of the app",
        style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13)
      ),
    ),
          ),
    
    
          
        ]);
  }
}
