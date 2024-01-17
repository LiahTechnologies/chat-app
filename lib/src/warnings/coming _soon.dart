import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class ComiingSoon extends StatelessWidget {
  const ComiingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [

          Align(
            alignment: Alignment.topRight,
            child: IconButton(icon: Icon(Icons.close),onPressed: ()=>Get.back(),),
          ),
      Center(
        child: Text(
          "Coming Soon !",
          style:Theme.of(context).textTheme.displayMedium
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


      
    ]));
  }
}
