import '../../domain/entity/group-members.dart';

class GroupMembersModel extends GroupMembers{
  final String profilePic;
  final String firstName;
  final String lastName;
  final String number;
  final String uid;

  GroupMembersModel({required this.uid,required this.profilePic,required this.firstName,required this.lastName,required this.number}):super(uid: uid,firstName: firstName, lastName: lastName,profilePic: profilePic,number: number);


  factory GroupMembersModel.fromjson(Map<String, dynamic> json)=>GroupMembersModel(uid: json['_id'],profilePic: json["profilePic"]??"", firstName: json["firstName"], lastName: json["lastName"], number: json["tel"]);


}