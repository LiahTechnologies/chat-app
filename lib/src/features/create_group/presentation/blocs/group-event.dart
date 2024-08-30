import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entities/user-entity.dart';
import '../../../group_chat/domain/entities/group_chat_entity.dart';
import '../../domain/entities/group-entity.dart';

class GroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class OnCreateGroup extends GroupEvent{
  final GroupEntity groupEntity;
  final File profilePic;
  OnCreateGroup({required this.groupEntity,required this.profilePic});

  @override
  List<Object?> get props=>[groupEntity];

}

class OnError extends GroupEvent{}

class OnGroupCreated extends GroupEvent{}

class OnGetGroupAdmins extends GroupEvent{
  final String groupId;
 
  OnGetGroupAdmins({required this.groupId});


}

class OnGetGroupMembers extends GroupEvent{
    final String groupId;
  OnGetGroupMembers({required this.groupId});

 
}

class OnGroupAdminsLoaded extends GroupEvent{
   final List<UserEntity> groupAdmins;
  OnGroupAdminsLoaded({required this.groupAdmins});

    @override
  List<Object?> get props=>[groupAdmins];
}

class OnGroupMembersLoaded extends GroupEvent{
   final List<UserEntity> groupMembers;
  OnGroupMembersLoaded({required this.groupMembers});

    @override
  List<Object?> get props=>[groupMembers];
}

class OnDeleteGroupAdmin extends GroupEvent{
   final String groupId;
   OnDeleteGroupAdmin({required this.groupId});
}
class OnDeleteGroupMember extends GroupEvent{
   final String groupId;
   OnDeleteGroupMember({required this.groupId});
}

class OnAddroupAdmin extends GroupEvent{
   final String groupId;
   final String adminId;

   OnAddroupAdmin({required this.adminId, required this.groupId});
}
class OnAddGroupMember extends GroupEvent{
   final String groupId;
   final String memberId;

   OnAddGroupMember({required this.groupId, required this.memberId});
}


