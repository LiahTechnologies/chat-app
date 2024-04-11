
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import '../../../../core/common/constants/style/color.dart';
import '../widgets/groupTile.dart';
import 'group_template_option.dart';

class AllGroups extends StatefulWidget {
  const AllGroups({super.key});

  @override
  State<AllGroups> createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {
  final TextEditingController searchController = TextEditingController();
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // getUserData();
    super.initState();
  }

  String userName = '';
  String userEmail = '';
  Stream? group;

  // Stream<QuerySnapshot>? lastChat;

  // getUserData() async {
  //   await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
  //       .getUserGroup()
  //       .then((snapshot) {
  //     setState(() {
  //       // print(" THE GROUP HAVE BEEN FETECHED");
  //       group = snapshot;
  //       // print("group lenght is ${snapshot}");
  //     });
  //   });
  // }

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Njangi Groups",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          // await getUserData();
        },
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                grouplist() 
                ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NextScreen(context: context, page: GroupTemplateOption()),
        
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
        backgroundColor: AppColor.greenColor,
      ),
    );
  }

  grouplist() {
    return StreamBuilder(
        stream: group,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
             if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                print("THE LIST OF GROUPS ARE ${snapshot.data['groups'].length}");
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      var reverseIndex =
                          snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          userName: snapshot.data['firstName'],
                          groupid:
                              getId(snapshot.data['groups'][reverseIndex]));
                    });
              } else {
                return Text("No Group Created");
                // return noGroupWidget();
              }
            } else {
              return Text("No Group Created");

              // return noGroupWidget();
            }

          } else {
            return Container(
                height: 560.h,
                child: const Center(child: Text("No Group Created")));
          }
        });
  }
}
