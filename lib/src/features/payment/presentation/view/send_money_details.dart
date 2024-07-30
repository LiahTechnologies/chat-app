import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/payment/presentation/widgets/customPaymentInput.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../warnings/warning.dart';

class SendMoneyDetail extends StatelessWidget {
  SendMoneyDetail(
      {super.key, this.amount = 25000, this.name = "Erling Haland", required this.groupName});

  final int amount;
  final String name;
  final String groupName;


  final TextEditingController referenceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: CustomBackArrow(),
        title: Column(
          children: [
            Text("Send  Money",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),
            Text("${groupName}",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white)),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Send the sum of",
                  style: Theme.of(context).textTheme.displaySmall),
              TextSpan(
                  text: " ${this.amount}",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w800))
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "To ", style: Theme.of(context).textTheme.displaySmall),
              TextSpan(
                  text: "${this.name}",
                  style: Theme.of(context).textTheme.displayMedium)
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
              child: Text("PAYMENT METHOD",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "MoMo User",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recipient Number",
                      style: Theme.of(context).textTheme.displaySmall),
                  Text("670034409",
                      style: Theme.of(context).textTheme.displaySmall),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).iconTheme.color!)),
                    child: Row(
                      children: [
                        Text("Change",
                            style: Theme.of(context).textTheme.displaySmall),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).iconTheme.color,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            //   child:const  CustomPaymetInput()
            // ),

            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount (XAF)",
                      style: Theme.of(context).textTheme.displaySmall),
                  Text("25,000",
                      style: Theme.of(context).textTheme.displaySmall),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).iconTheme.color!)),
                    child: Row(
                      children: [
                        Text("Change",
                            style: Theme.of(context).textTheme.displaySmall),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).iconTheme.color,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            //   child: CustomPaymetInput(),
            // ),

             SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w, top: 10.h),
                child: Text("My Reference",
                    style: Theme.of(context).textTheme.displaySmall),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: CustomPaymetInput(controller: referenceController)),
            SizedBox(
              height: 50.h,
            ),
            CustomButton(
              onPress: () {
                if (referenceController.text.isEmpty)
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomWarning(text: "Field can not be empty",);
                      });
                else
                  !isLoading
                      ?showModalBottomSheet(context: context, builder: (context)=> showCustomeButtonSheet(context,
                              image: AppImages.PROCESSING_ICON),)
                      
                      
                      
                      : showModalBottomSheet(context:context,builder:(context)=>
                          showCustomeButtonSheet(context,
                              image: AppImages.DONE__ICON,
                              text: "Done",
                              subtitle: "Continue",
                              fonts: 19),
                          enableDrag: true);
              },
              text: "Pay now ",
              width: 250.w,
              icon: null,
            )
          ],
        )),
      ),
    );
  }

  showCustomeButtonSheet(BuildContext context,{image, text, String? subtitle, double? fonts}) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              "$text",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: fonts!),
            ),
          ),
          Center(
            child: Text(
              "$subtitle",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}
