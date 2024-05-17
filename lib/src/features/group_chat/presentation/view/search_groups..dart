
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';


import '../../../../core/common/helper_function.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({super.key});

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
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
      body: Column(
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
                        hintText: "Search for a group by name",
                        hintStyle: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: () {
/*
                    if (groupName.text.isNotEmpty)
                      initiatSearchAction();
                    else
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomWarning(
                              text: "Enter Group Name",
                            );
                          });

                          */
                    // setState(() {
                    //   databaseServices.searchbyName(groupName.text);
                    // });
                  },
                )
              ],
            ),
          ),
          // FutureBuilder<QuerySnapshot>(
          //     future: groupList!,
          //     builder: (context, snapshot) {
          //       return ListView.builder(
          //           itemBuilder: (context, Index) => Container());
          //     })

          isLoading
              ? Container(
                height: 300.h,
                child: Center(
                  child: CircularProgressIndicator(color: Theme.of(context).iconTheme.color,),
                ),
              )
              : Container(
                  // child: groupList(),
                )
        ],
      ),
    );
  }

/*
  initiatSearchAction() async {
    if (groupName.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
          .searchbyName(groupName.text)
          .then((value) {
        setState(() {
          searchGroups = value;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchGroups!.docs.length,
            itemBuilder: (context, index) {
              print(searchGroups!.docs[index]["groupId"]);
              print(searchGroups!.docs[index]["groupName"]);

              return groupTile(
                userName: userName,
                groupName: searchGroups!.docs[index]["groupName"],
                groupId: searchGroups!.docs[index]["groupId"],
                admin: '',
              );
            })
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
    await DatabaseServices(uid: user!.uid)
        .isUserJoin(groupName: groupName, groupId: groupId, userName: userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  Widget groupTile(
      {required String userName,
      required String groupId,
      required String groupName,
      required String admin}) {
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      leading: CircleAvatar(
      
        radius: 20,
        backgroundColor: AppColor.secondary,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor.whiteColor),
        ),
      ),
      title: Text(
        groupName,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      trailing: InkWell(
        onTap: () async {
          await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
              .toggleGroupJoin(
                  groupId: groupId, userName: userName, groupName: groupName)
              .then((value) {
            if (isJoined) {
              setState(() {
                isJoined = !isJoined;
                 Get.toNamed(AppRoutes.HOMEpAGE);
              });
             
            }
          });
        },
        child: isJoined
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.purpleColor,
                  border: Border.all(color: AppColor.whiteColor, width: 1),
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
                  color: AppColor.purpleColor,
                  border: Border.all(color: AppColor.whiteColor, width: 1),
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

  */
}
