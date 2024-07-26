


import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';

class SearchGroupState{}


class Empty extends SearchGroupState{}

class GroupLoading extends SearchGroupState{}

class GroupLoaded extends SearchGroupState{
  final GroupChatEntity groupChatEntity;

  GroupLoaded({required this.groupChatEntity});

}


class UserJoinGroup extends SearchGroupState{
    final bool status;
    UserJoinGroup({required this.status});

}

class CheckUserJoinGroup extends SearchGroupState{
    final bool status;
    CheckUserJoinGroup({required this.status});

}

class ErrorSearchingGroup extends SearchGroupState{}