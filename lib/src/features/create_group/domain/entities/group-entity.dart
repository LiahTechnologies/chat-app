
import 'dart:io';

class GroupEntity{
  final String? profilePic;
  final String groupName;
  final String groupIcon;
  final List<String> members;
  final List<String> admins;
  final String levy;
  final String limit;

  
  GroupEntity({ this.profilePic,required this.groupName, required this.groupIcon, required this.members, required this.levy, required this.admins, required this.limit});
  
  
  
  }