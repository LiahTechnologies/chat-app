
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-bloc.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-event.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-state.dart';
import 'package:njadia/src/features/search-groups/presentation/widget/group-tile.dart';


import '../../../../core/common/helper_function.dart';
import '../../../../warnings/warning.dart';
import '../../../group_chat/presentation/widgets/groupTile.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({super.key});

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    getcurrentUserIdandName();
    super.initState();
  }

  getcurrentUserIdandName() async {
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });

    // user = FirebaseAuth.instance.currentUser;
  }


  String userName = "";
  // User? user;
  bool isJoined = false;
  // final databaseServices = DatabaseServices();

  final TextEditingController groupName = TextEditingController();

  // QuerySnapshot? searchGroups;
  bool isLoading = false;
  bool hasUserSearched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: const CustomBackArrow(),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          "Search Njangi Groups",
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white),
        ),
        
      ),
      body: BlocConsumer<SearchGroupBloc,SearchGroupState>(
        builder: (context,state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(color: AppColor.darkIconColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      width: 295.w,
                      height: 20.h,
                      // color: AppColor.grayColor,
                      child: TextField(
                        controller: groupName,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter group name",
                            hintStyle: Theme.of(context).textTheme.displaySmall),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search,
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
          
                        if (groupName.text.isNotEmpty)
                          initiatSearchAction();
                        else
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const CustomWarning(
                                  text: "Enter Group Name",
                                );
                              });
          
                              
                        // setState(() {
                        //   databaseServices.searchbyName(groupName.text);
                        // });
                      },
                    )
                  ],
                ),
              ),
              // FutureBuilder<QuerySnapshot>(
              //     future: groupList,
              //     builder: (context, snapshot) {
              //       return ListView.builder(
              //           itemBuilder: (context, Index) => Container());
              //     }),
          
              if(state is GroupLoading)
              
                   Container(
                    height: 300.h,
                    child: Center(
                      child: CircularProgressIndicator(color: Theme.of(context).iconTheme.color,),
                    ),
                  ),


                if(state is ErrorSearchingGroup)
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Center(child: Text("Error Fetching Group, Try to check the Name and Letter Case "),),
                  ),
              if(state is GroupLoaded)
                  GroupSearcTile( groupPic: state.groupChatEntity.profilePic??"", groupName: state.groupChatEntity.groupName??"",groupId: state.groupChatEntity.id??"" )
                  
            ],
          );
        }, listener: (BuildContext context, state) {  
          if(state is ErrorSearchingGroup){
            print("tHE CURRENT STATE IS ErrorSearchingGroup");
          }

          if(state is GroupLoading){
            print("tHE CURRENT STATE IS GroupLoading");
          }
        },
      ),
    );
  }

 
  initiatSearchAction() async {
    if (groupName.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      context.read<SearchGroupBloc>().add(OnGroupFetch(groupName: groupName.text.trim()));

    
     
    }
  }

  groupList() {
    return hasUserSearched
        ?  GroupTile(
                userName: userName,
                groupName: "Liah",
                // groupId: "ajdjal",
                // admin: 'akjdjsj',
              )
          
        : Container(
            height: 305.h,
            child: Center(
              child: Text(
                "Empty",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
  }

  joinedOrNot(String userName, groupId, String groupName, String admin) async {
    // await DatabaseServices(uid: user!.uid)
    //     .isUserJoin(groupName: groupName, groupId: groupId, userName: userName)
    //     .then((value) {
    //   setState(() {
    //     isJoined = value;
    //   });
    // });
  }

  Widget groupTile(
      {required String userName,
      required String groupId,
      required String groupName,
      required String admin
      }) {
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      leading: CircleAvatar(
      
        radius: 20,
        backgroundColor: AppColor.darkAppBarColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor.LightAppBarColor),
        ),
      ),
      title: Text(
        groupName,
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
                  color: AppColor.darkAppBarColor,
                  border: Border.all(color: AppColor.darkAppBarColor, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Joined",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.darkAppBarColor,
                  border: Border.all(color: AppColor.LightAppBarColor, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Join now",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
      ),
    );
  }

  
}
