import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

class SendMoney extends StatelessWidget {
  const SendMoney(
      {super.key, this.amount = 25000, this.name = "Erling Haland"});

  final int amount;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: CustomBackArrow(),
        centerTitle: true,
        title: Column(
                    children: [
                      Text(
                        "Send  Money",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "Ekondo Njangi",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
           
           
            Text.rich(TextSpan(children: [
              TextSpan(text: "Send the sum of ", style: Theme.of(context).textTheme.displaySmall,),
              TextSpan(
                  text: "$amount",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w800),)
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(text: "To ",style: Theme.of(context).textTheme.displayMedium,),
              TextSpan(
                  text: "$name",
               style: Theme.of(context).textTheme.displaySmall,
                 )
            ])),
            SizedBox(
              height: 5.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.w),
              height: 50.h,
              width: double.infinity,
              color: Theme.of(context).cardTheme.color,
              child: Text(
                "Payment Method",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.SEND_MONEY_DETAIL_PAGE);

                 
                 
                 
                },
                child: Image.asset(AppImages.MTP)),
            SizedBox(
              height: 3.h,
            ),
            Image.asset(AppImages.ORANGE),
          ],
        )),
      ),
    );
  }









}
