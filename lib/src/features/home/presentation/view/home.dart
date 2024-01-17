import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_chat/presentation/view/all-groups.dart';
import 'package:njadia/src/features/direct%20message/presentation/view/direct-message.dart';
import 'package:njadia/src/features/group_chat/presentation/view/search_groups..dart';
import 'package:njadia/src/features/payment/presentation/view/group_home_page.dart';
import 'package:njadia/src/features/profile/presentation/views/profile.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/common/constants/style/appfont.dart';
import 'package:njadia/src/common/constants/style/color.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';

import '../../../../common/helper_function.dart';
import '../../../../common/services/firebase_messaging.dart';
import '../../../group_chat/presentation/widgets/groupTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  String userName = '';
  String userEmail = '';
  Stream? group;

  getUserData() async {
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
    await HelperFunction.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });

    print(
        "THIS IS THE LIST OF GROUPS  ${FirebaseAuth.instance.currentUser!.uid}");
    print(" THE NUMBE OF GROUPS IS  ${await group!.length}");
  }

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

// List fo pages

  final Screens = const [AllGroups(), DirectMessage(), SearchGroups(), Profile()];

  int currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Screens[currentScreen],
       
        bottomNavigationBar: CurvedNavigationBar(
          height:50.h,
          backgroundColor: Theme.of(context).colorScheme.primary,
          // backgroundColor: AppColor.transparent,
          color: Theme.of(context).colorScheme.secondary,
           key: _bottomNavigationKey,
          items: [
          Icon(Icons.home,size: 18,),
           Icon(Icons.group,size: 18,),
            Icon(Icons.search,size: 18,),
             Icon(Icons.person,size: 18,),
        ],
        onTap: (value){
          setState(() {
              currentScreen = value;
          });
        },
        
        )


        
        /*BottomAppBar(
            child: Container(
          height: 50.h,
          color: AppColor.greenColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = 0;
                    });
                  },
                  icon: Icon(Icons.home,color: currentScreen==0?AppColor.whiteColor:AppColor.blackColor,)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = 1;
                    });
                  },
                  icon: Icon(Icons.group,color: currentScreen==1?AppColor.whiteColor:AppColor.blackColor,)),
          

              IconButton(
                  onPressed: (){
                    setState(() {
                      currentScreen = 2;
                    });
                  },
                  icon: Icon(Icons.search,color: currentScreen==2?AppColor.whiteColor:AppColor.blackColor,)),

          
              IconButton(
                  onPressed: (){
                    setState(() {
                      currentScreen = 3;
                    });
                  },
                  icon: Icon(Icons.person,color: currentScreen==3?AppColor.whiteColor:AppColor.blackColor,))
            ],
          ),
        )),*/


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
                return Text("");
                // return noGroupWidget();
              }
            } else {
              return Text("");
              // return noGroupWidget();
            }
          } else {
            return Container(
                height: 560.h,
                child: const Center(child: Text("No Group Created")));
          }
        });
  }
/*
  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  size: 22,
                )),
            SizedBox(
              height: 25,
            ),
            Text(
                "You have not joined any group, tap on the addicon to create a new group or also search groups")
          ]),
    );
  }*/
}
