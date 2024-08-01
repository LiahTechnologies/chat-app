
import '../../domain/entity/group-members.dart';

class GroupMemberState{

}

class GroupMemberEmtpy extends GroupMemberState{}
class GroupMemberLoading extends GroupMemberState{}

class GroupMemberLoaded extends GroupMemberState{
  final List<GroupMembers> memebrs;

  GroupMemberLoaded({required this.memebrs});
   
}

class GroupMemberError extends GroupMemberState{
  final String error;

  GroupMemberError({required this.error});

}