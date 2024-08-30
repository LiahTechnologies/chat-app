

import 'package:hive_flutter/hive_flutter.dart';

import '../../model/group_list_model.dart';


// import 'package:hive/hive.dart';

class LocalChatListDataSource{

    LocalChatListDataSource({required this.boxName});

  final String boxName;




 Future<Box<GroupModel>> get _box async =>
      await Hive.openBox<GroupModel>(boxName);



//create
  Future<void> insertGroupList(List<GroupModel> groupList) async {
    var box = await _box;
    for(final group in groupList){
       await box.put(group.groupName,group);
    }
  }



//read
  Future<List<GroupModel>> getAllGroupList() async {
    var box = await _box;
    return box.values.toList();
  }



//update
  Future<void> updateDeck(int index, GroupModel groupChatModel) async { 
    var box = await _box;
    await box.putAt(index, groupChatModel);
  }

//delete
  Future<void> deleteGroup(List<String> groupList) async { 
    var box = await _box;

    for(final group in groupList){
      await box.delete(group);    }
    
    }


}