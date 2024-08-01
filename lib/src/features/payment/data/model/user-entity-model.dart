import '../../domain/entity/group-members.dart';

class GroupMembersModel extends GroupMembers{
  final String profilePic;
  final String firstName;
  final String lastName;
  final String number;

  GroupMembersModel({required this.profilePic,required this.firstName,required this.lastName,required this.number}):super(firstName: firstName, lastName: lastName,profilePic: profilePic,number: number);


  factory GroupMembersModel.fromjson(Map<String, dynamic> json)=>GroupMembersModel(profilePic: json["profilePic"]??"", firstName: json["firstName"], lastName: json["lastName"], number: json["tel"]);


}