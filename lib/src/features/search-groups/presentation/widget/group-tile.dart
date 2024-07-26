import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/home/presentation/view/home.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-bloc.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-event.dart';

import '../../../../core/common/constants/style/color.dart';
import '../bloc/search-group-state.dart';

class GroupSearcTile extends StatefulWidget {
   GroupSearcTile({super.key,  required this.groupPic, required this.groupName, required this.groupId});

  final String groupId;
  final String groupPic;
  final String groupName;

  @override
  State<GroupSearcTile> createState() => _GroupSearcTileState();
}

class _GroupSearcTileState extends State<GroupSearcTile> {
  // final String admin;
   bool isJoined = false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
        // context.read<SearchGroupBloc>().add(OnUserJoin(groupId: widget.groupId));


    getUid();
  }

late String uid;

getUid()async{
//  setState(()  {
    uid= await HelperFunction.getUserID();
//  });
}
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SearchGroupBloc,SearchGroupState>(

      builder: (context,state) {
       
        

        if(state is GroupLoaded)

        return ListTile(
          leading: CircleAvatar(
          
            radius: 20,
            backgroundColor: AppColor.darkAppBarColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor.LightAppBarColor),
            ),
          ),
          title: Text(
            widget.groupName,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          trailing: InkWell(
            onTap: () async {
              // await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
              //     .toggleGroupJoin(
              //         groupId: groupId, userName: userName, groupName: groupName)
              //     .then((value) {
              //   if (isJoined) {
              //     setState(() {
              //       isJoined = !isJoined;
              //       //  Get.toNamed(AppRoutes.HOMEpAGE);
              //     });
                 
              //   }
              // });
            },

            
            child: isJoined
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      border: Border.all(color: AppColor.darkAppBarColor, width: 1),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Joined",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                    ),
                  )
                : InkWell(
                  onTap:(){
                    context.read<SearchGroupBloc>().add(OnJoinGroup(uid: uid, groupId: widget.groupId));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        border: Border.all(color: AppColor.LightAppBarColor, width: 1),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Join now",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                ),
          ),
        );

        else{
          return Text("state");
        }
      }, listener: (BuildContext context, SearchGroupState state) { 
        if(state is UserJoinGroup && state.status==true)
            nextScreen(context, HomePage());


        if(state is CheckUserJoinGroup)
       setState(() {
           isJoined=state.status;

          //  print("THE USER JOIN STATE IS ${state.status}");
       });
       },
    );
  }
}