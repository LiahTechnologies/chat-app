

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../group_chat/data/model/group_chat_model.dart';

// import 'package:hive/hive.dart';

class PrivateLocalSocketDataSource{

  PrivateLocalSocketDataSource({required this.boxName});
  final String boxName;
  Future<Box<GroupChatModel>> get _box async =>
      await Hive.openBox<GroupChatModel>(boxName);




//create
  Future<void> insertMessage(List<GroupChatModel> groupChatModel) async {
    var box = await _box;
    for(final groupChat in groupChatModel){
       await box.put(groupChat.messageId,groupChat);
    }
  }

//read
  Future<List<GroupChatModel>> getAllMessages() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateDeck(int index, GroupChatModel groupChatModel) async { 
    var box = await _box;
    await box.putAt(index, groupChatModel);
  }

//delete
  Future<void> deleteMessage(int index) async { 
    var box = await _box;
    await box.deleteAt(index);
  }


}