import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/core/common/chat_model_list_data.dart';
import 'package:njadia/src/core/utils/contact_card.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-event.dart';
import 'package:njadia/src/utils/naviagtion.dart';

import '../../../../core/common/constants/style/color.dart';
import '../bloc/group_chat-bloc.dart';
import '../bloc/group_list_bloc.dart';
import '../bloc/group_list_event.dart';
import '../bloc/group_list_state.dart';
import '../bloc/group_chat-state.dart';
import '../widgets/groupTile.dart';
import '../../../create_group/presentation/view/group_template_option.dart';

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
    // context.read<GroupListBloc>().add(OnGroupsLoainding(groupId: "Flutter_1"));
    super.initState();
  }

  String userName = '';
  String userEmail = '';

  Stream<String>? lastChat;

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

  List<PopupMenuItem> items = [
    PopupMenuItem(child: Text(""))
  ];

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
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Njangi Group",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // centerTitle: true,

        actions: [

           const Text("Text"),

          IconButton(
            onPressed: () {},
            icon:const Icon(Icons.search,color: Colors.black,),
          ),
          CustomPopUpMenu(items: items)


        ],
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          // await getUserData();
        },
        child: Container(
          // width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                listOfGroups()
               
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            NextScreen(context: context, page: GroupTemplateOption()),
        child:  Icon(
          Icons.add,
          color:Theme.of(context).iconTheme.color,
        ),
        backgroundColor: Theme.of(context).iconTheme.color,
      ),
    );
  }

  Widget listOfGroups() {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(contact: contacts[index]);
        });
  }

  // grouplist() {
  //   return BlocBuilder<GroupListBloc, GroupListState>(
  //       builder: (context, state) {
  //           print("DATA LOADED ${context.read<GroupListBloc>().stream.length}");
  //     return StreamBuilder(
  //         stream:state.groupChatEntityStream,
  //         builder: (context, AsyncSnapshot snapshot) {
  //           if (snapshot.hasData) {
  //             print("DATA LOADED ${snapshot.data}");
  //             if (snapshot.data['groups'] != null) {
  //               if (snapshot.data['groups'].length != 0) {
  //                 // print("THE LIST OF GROUPS ARE ${snapshot.data['groups'].length}");
  //                 return ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: 2,
  //                     itemBuilder: (context, index) {
  //                       // var reverseIndex =
  //                       //     snapshot.data['groups'].length - index - 1;
  //                       return GroupTile(
  //                           groupName: snapshot.data['groupName'],
  //                           userName: snapshot.data['firstName'],
  //                           groupid: getId(snapshot.data['groupId']));
  //                     });
  //               } else {
  //                 return const Text("No Group. Please create one");
  //                 // return noGroupWidget();
  //               }
  //             } else {
  //               return const Text("No Group, Please add one");

  //               // return noGroupWidget();
  //             }
  //           } else {
  //             return Container(
  //                 height: 560.h,
  //                 child: Center(child: Text("No Group Created")));
  //           }
  //         });
  //   });
  // }

  // grouplist() {
  //   return BlocBuilder<GroupListBloc, GroupListState>(
  //       builder: (context, state) {
  //           print("DATA LOADED ${context.read<GroupListBloc>().stream.length}");
  //     return FutureBuilder<GroupListState>(
  //         // future: state,
  //         builder: (context, AsyncSnapshot snapshot) {
  //           if (snapshot.hasData) {
  //             print("DATA LOADED ${snapshot.data}");
  //             if (snapshot.data['groups'] != null) {
  //               if (snapshot.data['groups'].length != 0) {
  //                 // print("THE LIST OF GROUPS ARE ${snapshot.data['groups'].length}");
  //                 return ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: 2,
  //                     itemBuilder: (context, index) {
  //                       // var reverseIndex =
  //                       //     snapshot.data['groups'].length - index - 1;
  //                       return GroupTile(
  //                           groupName: snapshot.data['groupName'],
  //                           userName: snapshot.data['firstName'],
  //                           groupid: getId(snapshot.data['groupId']));
  //                     });
  //               } else {
  //                 return const Text("No Group. Please create one");
  //                 // return noGroupWidget();
  //               }
  //             } else {
  //               return const Text("No Group, Please add one");

  //               // return noGroupWidget();
  //             }
  //           } else {
  //             return Container(
  //                 height: 560.h,
  //                 child: Center(child: Text("No Group Created")));
  //           }
  //         });
  //   });
  // }
}
