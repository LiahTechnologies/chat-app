
/// ----[CREATE GROUP]



class CreateGroupService{
  /// ---Variables
  // final authDatabase =
  //     DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid);
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  // final userName = FirebaseAuth.instance.currentUser!.displayName;

  ///  --- ReadMe(Docs[5]) ---Create Group Services

 /* Future createNewNjangiGroup(
      {required String groupName,
      required String groupLevi,
      required String groupLimit}) async {
    print("CREATE GROUP SERVICES CLASSS");

    return await authDatabase.createGroup(
        FirebaseAuth.instance.currentUser!.displayName!, userId, groupName, groupLevi, groupLimit);

    
  }

  Future<bool> checkIFGroupExist(String groupName)  {
    // return await authDatabase.checkIfGroupExist(groupName);

    return await false;
  }*/
}

class ReplyMessageController{
  // var reply = ReplyMessage(message: "", sender: "").obs;
  var replySender = "";
  var replyMessage = "";
  var showReplyDialog = false;

  setReplyMessage({replysender, replymessage}) {
    replySender = replysender;
    replyMessage = replymessage;
    showReplyDialog = true;
  }
}
