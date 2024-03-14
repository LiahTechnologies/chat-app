import 'package:get/get.dart';

/// ----[CREATE GROUP]

import 'package:njadia/src/features/group_chat/domain/send_reply_message.dart';
import 'package:njadia/src/routing/approutes.dart';

class CreateGroupService extends GetxController {
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

class ReplyMessageController extends GetxController {
  // var reply = ReplyMessage(message: "", sender: "").obs;
  var replySender = "".obs;
  var replyMessage = "".obs;
  var showReplyDialog = false.obs;

  setReplyMessage({replysender, replymessage}) {
    replySender.value = replysender;
    replyMessage.value = replymessage;
    showReplyDialog.value = true;
  }
}
