import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';

import 'package:njadia/src/utils/customInput.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/utils/opneCamera.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../utils/CustomButton.dart';
import '../../../group_chat/presentation/view/group-chat-page.dart';
import '../../../home/presentation/view/home.dart';
import '../blocs/group-bloc.dart';
import '../blocs/group-event.dart';
import '../blocs/group-state.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  // final contorller = CreateGroupService();
  String groupName = '';
  String groupLimit = '';
  String groupAmount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: CustomBackArrow(),
          centerTitle: true,
          title: Text("Create your Njangi group",
              style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white)),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: TextButton.icon(
                //       onPressed: () {
                //         Get.back();
                //       },
                //       icon: Icon(
                //         Icons.arrow_back_ios,
                //         size: 11,
                //         color: Theme.of(context).iconTheme.color
                //       ),
                //       label: Text(
                //         "Back",
                //         style: Theme.of(context).textTheme.displayMedium,
                //       )),
                // ),
                // Center(child: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("Create your Njangi group", style: Theme.of(context).textTheme.titleMedium),
                // )),

                 SizedBox(
                  height: 5.h,
                ),
                Text("Begin your collective saving journey, hangout and experience the power of communal finance",
                    style: Theme.of(context).textTheme.displayMedium),
                // Text(
                //   "",
                //   style: Theme.of(context).textTheme.displayMedium,
                // ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                    width: 140.w,
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Stack(children: [
                      DottedBorder(
                          strokeWidth: 2,
                          borderType: BorderType.Circle,
                          radius: Radius.circular(70),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleAvatar(
                                radius: 50.w,
                                backgroundImage: AssetImage(AppImages.PERSON),
                              ))),
                      Positioned(
                        right: 25.w,
                        top: 3.h,
                        child: GestureDetector(
                          onTap: () {
                            openCamera(method: "gallery");
                          },
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColor.lightButtonColor),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18.w,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomInput(
                  text: "NJANGI NAME",
                  controller: (value) {
                    groupName = value;
                  },
                  hint: "Ekondo Titi Njangi",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomInput(
                      text: "MEMBERS LIMIT",
                      controller: (value) {
                        groupLimit = value;
                      },
                      hint: "50",
                      width: 140,
                    ),
                    CustomInput(
                      text: "CONTRIBUTION AMOUNT",
                      controller: (value) {
                        setState(() {
                          groupAmount = value;
                        });
                      },
                      hint: "25,000XAF",
                      width: 200,
                    ),
                  ],
                ),
                SizedBox(
                  height: 150.h,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "By creating a server, you agree to Njadia's",
                      style: Theme.of(context).textTheme.displayMedium),
                  TextSpan(
                      text: " community guidelines",
                      style: Theme.of(context).textTheme.displayMedium),
                ])),
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<GroupBloc,GroupState>(
                  builder: (context,state) {
                    return Center(
                      child: CustomButton(
                        onPress: () async {
                    
                        /*
                    
                          if (groupName.isNotEmpty ||
                              groupAmount.isNotEmpty ||
                              groupLimit.isNotEmpty)
                            await contorller
                                .checkIFGroupExist(groupName)
                                .then((value) {
                              value
                                  ? contorller
                                      .createNewNjangiGroup(
                                          groupName: groupName,
                                          groupLevi: groupAmount,
                                          groupLimit: groupLimit)
                                      .then((Value) =>
                                          Get.toNamed(AppRoutes.HOMEpAGE))
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomWarning(
                                          text: "Group Already Exist",
                                        );
                                      });
                              groupAmount = groupName = groupLimit = "";
                            });
                          else
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomWarning(
                                    text: "Fields can not be empty",
                                  );
                                });
                    
                    members[]
                               */ 
                              final groupEntity = GroupEntity(groupName: groupName, groupIcon: "groupIcon", members: ["members"], levy: groupAmount, admins: ["admins"],limit: groupLimit);

                           context
                                .read<GroupBloc>()
                                .add(OnCreateGroup(groupEntity: groupEntity));
                       
                        nextScreen(context, HomePage());


                        },
                        text: "CreatE Njangi",
                        icon: null,
                        borderRadius: 12,
                        width: 290.w,
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ));
  }
}
