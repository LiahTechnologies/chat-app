

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../group_chat/data/model/group_chat_model.dart';
import '../../model/user-profile-model.dart';

// import 'package:hive/hive.dart';

class PrivateLocalChatListDataSource{

PrivateLocalChatListDataSource({required this.boxName});

  final String boxName;




 Future<Box<UserProfileModel>> get _box async =>
      await Hive.openBox<UserProfileModel>(boxName);


//create
  Future<void> addChatList(List<UserProfileModel> userChatList) async {
     var box = await _box;
    for(final user in userChatList){
       await box.put(user.uid,user);
    }
  }



//read
  Future<List<UserProfileModel>> getAllUsers() async {
    var box = await _box;
    return box.values.toList();
  }



//update
  Future<void> updateDeck(int index, UserProfileModel groupChatModel) async { 
    var box = await _box;
    await box.putAt(index, groupChatModel);
  }

//delete
  Future<void> deletePerson(int index) async { 
    var box = await _box;
    await box.deleteAt(index);
  }


}