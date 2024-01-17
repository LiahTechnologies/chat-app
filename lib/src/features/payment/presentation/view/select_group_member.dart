import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

class SelectGroupMember extends StatelessWidget {
  const SelectGroupMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   CustomBackArrow(),
                    SizedBox(
                      width: 70.w,
                    ),
                    Column(
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
                    )
                  ],
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Chukwi Obi",
                        hintStyle: Theme.of(context).textTheme.displaySmall,
                        suffixIcon: Icon(
                          Icons.cancel_outlined,
                          color: Theme.of(context).iconTheme.color,
                        )),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.w),
                  height: 50.h,
                  width: double.infinity,
                  color: Theme.of(context).cardTheme.color,
                  child: Text(
                    "Members",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.SEND_MONEY_PAGE);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text("Gael Indira",style: Theme.of(context).textTheme.displaySmall,), Divider()],
                              ),
                            ),
                          );
                        }))
              ],
            )),
      ),
    );
  }
}
