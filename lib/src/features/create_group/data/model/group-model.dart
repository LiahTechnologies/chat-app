
import 'package:njadia/src/features/create_group/domain/entities/group-entity.dart';
import 'package:njadia/src/features/create_group/presentation/blocs/group-state.dart';

class GroupModel extends GroupEntity{
   final String groupName;
   final String  groupIcon;
   final List<String> members;
   final List<String> admins;
   final String levy;
   final String limit;

  GroupModel({required this.groupName, required this.groupIcon, required this.members, required this.admins, required this.levy, required this.limit}) : super(groupName: groupName, groupIcon:groupIcon, members: members, levy:levy, admins: admins, limit: limit); 



  factory GroupModel.fromjson(Map<String,dynamic>json)=>
  GroupModel(
    groupName: json['groupName'],
    groupIcon: json['groupIcon'], 
    members: json['members'], 
    admins: json['admins'], 
    levy: json['levy'], 
    limit: json['limit']
    
    );



  Map<String,dynamic> toJson()=>{
      "groupName":groupName,
      "groupIcon":groupIcon,
      "groupMembers":members,
      "groupAdmins":admins,
      "groupLevy":levy,
      "limit":limit
  };



}