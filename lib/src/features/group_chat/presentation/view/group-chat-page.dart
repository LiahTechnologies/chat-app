import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/utils/custom_popup_menu.dart';

import '../../../../core/model/chat_model.dart';
import '../../../../core/utils/custom_card.dart';
import '../../../direct message/domain/entities/chat.dart';
import '../../../create_group/presentation/view/group_template_option.dart';
import '../bloc/group_list_bloc.dart';
import '../bloc/group_list_state.dart';

class GroupChatPage extends StatelessWidget {
   GroupChatPage({super.key});

  List<PopupMenuItem> popItems = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: AppColor.lightButtonColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GroupTemplateOption()));
        },
        child:  Icon(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Theme.of(context).bottomAppBarTheme.shadowColor)),
          CustomPopUpMenu(items: popItems)
        ],
      ),
      body: BlocBuilder<GroupListBloc,GroupListState>(
        builder: (context,state) {

         
          if(state is GroupListLoaded){
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) => CustomCard(
                    chatModel: Chat(chatId: state.groups[index].id,  profilePic: state.groups[index].profilePic, time: "12:00pm", userName: state.groups[index].groupName, isGroup: true, lastMessage: ""),
                  ));
          }

          return Center(
              child: CircularProgressIndicator(),
            );
         
        }
      ),
    );
  }
}
