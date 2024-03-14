import 'package:get/get.dart';

/// ----[CREATE GROUP]

import 'package:njadia/src/routing/approutes.dart';

class DirectMessageController extends GetxController {
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



class DirectReplyMessageController extends GetxController {
  // var reply = ReplyMessage(message: "", sender: "").obs;
  var replySender = "".obs;
  var replyMessage = "".obs;
  var showReplyDialog = false.obs;

  setReplyMessage({replysender, replymessage}) {
    replySender.value = replysender;
    replyMessage.value = replymessage;
    showReplyDialog .value= true;
  }
}