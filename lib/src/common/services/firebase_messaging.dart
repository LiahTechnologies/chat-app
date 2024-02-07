import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../helper_function.dart';
import '../../features/direct message/domain/entities/message.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

//
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("group");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  Future updateUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String dateOfBirth,
  }) {
    
    print("CREATING USERS DOCUMENT DETAILS");

    final userResponse = userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "phoneNumber": phoneNumber,
      'dataOfBirth': dateOfBirth,
      'groups': [],
      'chats': [],
      'uid': uid
    });
    print("THIS IS THE RESPONSE FROM CREATING A USER ${userResponse}");
    return userResponse;
  }

  //getting user data

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();

    return snapshot;
  }

  Future getUserGroup() async {
    return await userCollection.doc(uid).snapshots();
  }

  Future createGroup(String userName, String id, String groupName,
      String groupLimit, String groupLevi) async {
    print("CREATING NJANGI GROUP");
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "groupLevi": groupLevi,
      "groupLimit": groupLimit,
      "recentMessage": "",
      "recentMessageSender": ""
    });

    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(["${id}_$userName"]),
      'groupId': groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(id);
    return await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

// getting chats

  Future<Stream<QuerySnapshot>> getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future deleteChat(String groupId, String messageId) async {
    return groupCollection
        .doc(groupId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Future<String> getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return await documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupid) async {
    return groupCollection.doc(groupid).snapshots();
  }

  // search by name
  Future<QuerySnapshot> searchbyName(String groupName) async {
    return await groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  Future<bool> isUserJoin(
      {required groupName, required groupId, required userName}) async {
    DocumentReference userDocumentReference = userCollection.doc(uid!);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      print("user joined");
      return true;
    } else {
      print("user not joined");
      return false;
    }
  }

  //

  Future<bool> checkIfUserExist(String email) async {
    final users = await userCollection.where("email", isEqualTo: email).get();

    if (users.docs.length == 0)
      return true;
    else
      return false;
  }

  Future<bool> checkIfGroupExist(String group) async {
    final users =
        await userCollection.where("groupName", isEqualTo: group).get();
    if (users.docs.length == 0)
      return true;
    else
      return false;
  }

  // toggling the join or not button

  Future<bool> toggleGroupJoin(
      {required groupId, required userName, required groupName}) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    //

    // print("JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid ");

    if (groups.contains("${groupId}_${userName}")) {
      print(" IF JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid ");
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_${userName}"])
      });
      return true;
    } else {
      print(
          " else JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid   $userName    $groupName");
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_${userName}"])
      });
      return true;
    }
  }

  sendMessage(
      {required groupId, required Map<String, dynamic> chatMessages}) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessages);
    groupCollection.doc(groupId).update({
      'message': chatMessages['message'],
      "messageId": chatMessages['messageId'],
      'sender': chatMessages['sender'],
      'time': chatMessages['time'].toString(),
      "replyMessage": chatMessages['replyMessage'],
      "replySender": chatMessages['replySender'],
      "senderNumber": chatMessages['senderNumber'],
      "senderId": chatMessages['senderId'],
    });

    print("The current user is ${chatMessages['sender']}");
  }

  // DIRECT MESSAGING

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  Future<String> createChat({
    required String recipientId,
    required String sendersId,
  }) async {
    print("CREATING NJANGI GROUP");
    DocumentReference chatDocumentReference = await chatCollection.add({
      "members": [],
      "chatId": "",
    });

    await chatDocumentReference.update({
      'members': FieldValue.arrayUnion(["${recipientId}"]),
      // 'members': FieldValue.arrayUnion(["${sendersId}"]),

      'chatId': chatDocumentReference.id
    });

    await chatDocumentReference.update({
      'members': FieldValue.arrayUnion(["${sendersId}"]),
      'chatId': chatDocumentReference.id
    });
    // await chatDocumentReference.update({
    //   // 'members': FieldValue.arrayUnion(["${sendersId}_$userName"]),
    //   'members': FieldValue.arrayUnion(["$sendersId"]),

    //   'chatId': chatDocumentReference.id
    // });
    DocumentReference userDocumentReference = userCollection.doc(recipientId);
    await userDocumentReference.update({
      'chats': FieldValue.arrayUnion(["${chatDocumentReference.id}"])
    });

    DocumentReference userDocumentReference2 = userCollection.doc(sendersId);
    await userDocumentReference2.update({
      'chats': FieldValue.arrayUnion(["${chatDocumentReference.id}"])
    });

    return chatDocumentReference.id;
  }

/*
  Future createChat(
      {required String recipientId, required String recipientName}) async {
    DocumentReference userDocumentReference = userCollection.doc(recipientId);
    final checkUser =
        await userCollection.where("chats", arrayContains: recipientId).get();

    if (checkUser.docs.length == 0) {
      await userDocumentReference.update({
        'chats':
            FieldValue.arrayUnion(["${FirebaseAuth.instance.currentUser!.uid}"])

        // 'chats': FieldValue.arrayUnion(["${FirebaseAuth.instance.currentUser!.uid}_${FirebaseAuth.instance.currentUser!.displayName}"])
      });

      DocumentReference recepientDocumentReference =
          userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

      await recepientDocumentReference.update({
        'chats': FieldValue.arrayUnion([
          "${recipientId}"
          //  "${recipientId}_${recipientName}"
        ])
      });
    }
  }*/

  Future sendChatMessage(
      {required Map<String, dynamic> chatMessages,
      required String chatId}) async {
    await chatCollection.doc(chatId).collection("messages").add({
      'message': chatMessages["message"],
      "messageId": chatMessages["messageId"],
      'sender': chatMessages["sender"],
      "replyMessage": chatMessages["replyMessage"],
      "replySender": chatMessages["replySender"],
      "senderId": chatMessages["senderId"],
      "recepientId": chatMessages["recepientId"],
      'time': chatMessages["time"],
    });

    // await chatCollection.doc(chatId).update({
    //   'message': chatMessages["message"],
    //   "messageId": chatMessages["messageId"],
    //   'sender': chatMessages["sender"],
    //   "replyMessage": chatMessages["replyMessage"],
    //   "replySender": chatMessages["replySender"],
    //   "senderId": chatMessages["sendId"],
    //   "recepientId": chatMessages["recepientId"],
    //   'time': chatMessages["time"],
    // });
  }

  Future<Stream<QuerySnapshot>> getChatMessages(String chatId) async {
    print("THIS IS THE CHAT ID $chatId");
    return chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  // Future getUserChatsList() async {
  //   return await userCollection.select();
  // }

  Future getUserChats() async {
    return await userCollection.doc(uid).snapshots();
  }

  Future getuserDetails(uid) async {
    final docs = await userCollection.where("uid", isEqualTo: uid).get();
    print("this is the current user details");
    print(docs);
  }
}
