import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';

class CustomWarning extends StatelessWidget {
  const CustomWarning({super.key, this.text="Friend request sent"});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [
          Icon(Icons.warning,size: 18,color: Colors.red,),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
     
    ]));
  }
}
