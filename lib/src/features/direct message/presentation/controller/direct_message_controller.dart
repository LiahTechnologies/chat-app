
/// ----[CREATE GROUP]


class DirectMessageController {
  /// ---Variables
  // final authDatabase = DatabaseServices(uid:FirebaseAuth.instance.currentUser!.uid );
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  // final userName = FirebaseAuth.instance.currentUser!.displayName;

  ///  --- ReadMe(Docs[5]) ---Create Group Services

  Future createChat(
      {required String userName,
      required String profileImg,
      required String userId}) async {
    print("CREATE GROUP SERVICES CLASSS");
    // return await authDatabase.createChat(recipientId: userId,sendersId: FirebaseAuth.instance.currentUser!.uid);
  }



}



class DirectReplyMessageController {
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