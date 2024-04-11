import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/constants/style/appfont.dart';
import 'package:njadia/src/utils/naviagtion.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  bool isChecked = true;
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
                  height: 20.h,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      child: Text(
                        "close",
                        style: AppFonts.defaultFonts,
                      ),
                      onPressed: () {
                        BackScreen(context: context);
                      },
                    )),
                Text(
                  "Add your contacts",
                  style: AppFonts.heading1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    "Always be able to reach your njangi members on njadia",
                    style: AppFonts.defaultFonts,
                  ),
                ),
                Container(
                  height: 450.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) =>
                          contacts(text: "Obi Kratos F", check: isChecked)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  onPress: () {},
                  text: "Send friend request",
                  icon: null,
                  borderRadius: 10,
                  width: 280.w,
                )
              ],
            ),
          ),
        ));
  }

  Widget contacts({text, check}) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(AppImages.PERSON)),
      title: Text(text),
      trailing: Checkbox(
        value: check,
        onChanged: (v) {
          setState(() {
            check = v!;
          });
        },
      ),
    );
  }
}
