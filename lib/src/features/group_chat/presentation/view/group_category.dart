import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/custom_card_items.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import 'package:njadia/src/warnings/coming%20_soon.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import 'create_group.dart';

class GroupCategory extends StatelessWidget {
  const GroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: CustomBackArrow(),
          centerTitle: true,
          title: Text("Select group categories",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     TextButton.icon(
                //         onPressed: () => Get.back(),
                //         icon: Icon(
                //           Icons.arrow_back_ios,
                //           size: 11,
                //           color: Theme.of(context).iconTheme.color,
                //         ),
                //         label: Text("Back",
                //             style: Theme.of(context).textTheme.displayMedium)),
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 6.0.w),
                  child: Text(
                      "Tell us more about your Njangi Group In order to help you",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.0.w),
                  child: Text(
                    "with the setup, is your new ngangi group just for a few friends ",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.0.w),
                  child: Text(
                    "or a large community",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                CustomCardItems(
                    image: AppImages.TWO_PEOPLE_ICON,
                    text: "For me and my age",
                    onTap: () {
                      NextScreen(context: context, page: CreateGroup());
                    }),
                CustomCardItems(
                    image: AppImages.TWO_PEOPLE_ICON,
                    text: "For me and my school mates",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ComiingSoon();
                          });
                    }),
                CustomCardItems(
                    image: AppImages.TWO_PEOPLE_ICON,
                    text: "For me and my church members",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ComiingSoon();
                          });
                    }),
                CustomCardItems(
                    image: AppImages.TWO_PEOPLE_ICON,
                    text: "For me and my work colleagues",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ComiingSoon();
                          });
                    }),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Not sure? ",
                        style: Theme.of(context).textTheme.displayMedium),
                    TextSpan(
                        text: "You can ",
                        style: Theme.of(context).textTheme.displayMedium),
                    TextSpan(
                        text: "skip this question ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 14)),
                    TextSpan(
                        text: "Not sure? ",
                        style: Theme.of(context).textTheme.displayMedium)
                  ])),
                )
              ],
            ),
          ),
        ));
  }
}
