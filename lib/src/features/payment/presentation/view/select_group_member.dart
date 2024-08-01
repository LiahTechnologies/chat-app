import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/features/payment/presentation/bloc/group-event.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../bloc/group-bloc.dart';
import '../bloc/group-state.dart';
import 'send_money.dart';

class SelectGroupMember extends StatelessWidget {
  const SelectGroupMember({super.key, required this.groupName, required this.groupId});
  final String groupName;
  final String groupId;
  @override
  Widget build(BuildContext context) {
    context.read<GroupMemberBloc>().add(OnFetchMembers(groupId: groupId));
    return Scaffold(
      appBar: AppBar(
        leading:const CustomBackArrow(),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Select receiver", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
        centerTitle: true,

      ),
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
                          "$groupName",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                   
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(9)
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search by name",
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          suffixIcon: Icon(
                            Icons.cancel_outlined,
                            color: Theme.of(context).iconTheme.color,
                          )),
                    ),
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
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                  ),
                ),



                BlocBuilder<GroupMemberBloc,GroupMemberState>(
                  builder: (context,state){

                   if(state is GroupMemberLoading)
                   return const Center(child: CircularProgressIndicator(),);
                  
                  else if (state is GroupMemberLoaded)
                    return   Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: state.memebrs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  NextScreen(context: context, page: SendMoney(groupName: groupName,name: "${state.memebrs[index].firstName} ${state.memebrs[index].lastName}",));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                  child: ListTile(
                                    leading: CircleAvatar(child: Image.asset(AppImages.PERSON),),
                                    title: Text(
                                      "${state.memebrs[index].firstName} ${state.memebrs[index].lastName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                ),
                              );
                            }));

                        else
                      return Center(child: Text("No member"),);
                  }
                )
              ],
            )),
      ),
    );
  }
}
