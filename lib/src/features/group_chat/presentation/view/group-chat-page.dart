import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/common/constants/style/style.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';

import '../../../../core/model/chatmodel.dart';
import '../../../../core/utils/custom_card.dart';
import '../../../direct message/domain/entities/chat.dart';
import '../../../create_group/presentation/view/group_template_option.dart';
import '../bloc/group_list_bloc.dart';
import '../bloc/group_list_event.dart';
import '../bloc/group_list_state.dart';
import 'chatroom.dart';
import 'group-socket-chat-room.dart';

class GroupChatPage extends StatefulWidget {
   GroupChatPage({super.key});

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  List<PopupMenuItem> popItems = [

  ];

  bool isSelcetGroups=false;

  bool isSelected= false;

  List<String>selectGroups=[];

  late List<Chat> chats ;

  getUserId() async{
    final uid = await HelperFunction.getUserID();
    print("${uid} THIS IS THEUSER ID ");
  }

  @override
  Widget build(BuildContext context) {
    context.read<GroupListBloc>().add(OnFetchGroups());
    getUserId();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: AppColor.lightButtonColor,
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>const GroupTemplateOption()));
        },
        child:const  Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Njangi Groups",
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(color: Colors.white),
        ),
        // centerTitle: true,

        actions: [
          if(isSelcetGroups)
           TextButton(onPressed: 
          (){
            context.read<GroupListBloc>().add(OnGroupDelete(groups: selectGroups));

            setState(() {
              isSelcetGroups=false;
            });
          }, child: Text("Delete",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.red),)),



          if(isSelcetGroups)
           TextButton(onPressed: 
          (){

            setState(() {
              isSelcetGroups=false;
            });
          }, child: Text("Cancel",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),)),

             if(!isSelcetGroups)
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Theme.of(context).bottomAppBarTheme.shadowColor)),
           if(!isSelcetGroups)
          CustomPopUpMenu(items: popItems,onSelected: (v){},)


       
        ],
      ),
      body: BlocConsumer<GroupListBloc,GroupListState>(
        builder: (context,state) {

         
          if(state is GroupListLoaded){
            // print("groups ${state.groups[0].id}");
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: (){
                    
                    // selectGroups.contains(state.groups[index].id);
                    setState(() {
                      isSelcetGroups=true;
                    });
                },
                child: ListTile(
                  trailing: isSelcetGroups? Checkbox(onChanged: (v){
                    setState(() {
                      if(!selectGroups.contains(state.groups[index].id))
                      selectGroups.add(state.groups[index].id!);
                      else selectGroups.remove(state.groups[index].id);
                    });
                  },value: selectGroups.contains(state.groups[index].id),side:const BorderSide(color: Colors.black,width: 2),activeColor: Colors.black,checkColor: Colors.white,):Text(""),
                  title: CustomCard(
                      onTap: (){
                            print("groups index ${state.groups[index].id}");
                      
                        Navigator.push(
                              context, MaterialPageRoute(builder: (context) => GroupChatRoom(chatModel: Chat(chatId: state.groups[index].id??"",  profilePic: state.groups[index].profilePic??"", time: "12:00pm", userName: state.groups[index].groupName??"", isGroup: true, lastMessage: "jjjl"),)
                              
                              // GroupChatRoom(chatModel:  Chat(chatId: state.groups[index].id??"",  profilePic: state.groups[index].profilePic??"", time: "12:00pm", userName: state.groups[index].groupName??"", isGroup: true, lastMessage: "jjjl"),
                            // )
                            ));
                      },
                   
                        chatModel: Chat(chatId: state.groups[index].id??"",  profilePic: state.groups[index].profilePic??"", time: "12:00pm", userName: state.groups[index].groupName??"", isGroup: true, lastMessage: "jjjl"),
                      ),
                ),
              ));
          }

          return Center(
              child: CircularProgressIndicator(),
            );
         
        }, listener: (BuildContext context, GroupListState state) { 
          if(state is GroupDeleted)
          setState(() {
            
          });
         },
      ),
    );
  }
}


