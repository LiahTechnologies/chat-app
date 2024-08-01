

class GroupMemberEvent {

}

class OnFetchMembers extends GroupMemberEvent{
  final String groupId;

  OnFetchMembers({required this.groupId});
}

