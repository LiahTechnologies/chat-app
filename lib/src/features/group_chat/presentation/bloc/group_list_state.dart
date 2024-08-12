import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../domain/entities/group_chat_entity.dart';

/*******GROUP LIST****** */

// final StreamController<GroupEntity> streamController =
//     StreamController<GroupEntity>();

// class GroupListState extends Equatable {
//   Stream groupChatEntityStream =streamController.stream.asBroadcastStream();

//   GroupListState(this.groupChatEntityStream);
//   @override
//   List<Object?> get props => [groupChatEntityStream];
// }

// class GroupEmpty extends GroupListState {
//   GroupEmpty(super.groupChatEntity);

//   @override
//   List<Object?> get props => [];
// }
// // class GroupLoading extends GroupListState {}

// class GroupListLoaded extends GroupListState {
//   GroupListLoaded(super.groupChatEntityStream);

// //   final Stream<GroupEntity> groupChatEntity;
// // //  final Future<GroupEntity> groupChatEntity;

// //   GroupListLoaded(super.groupChatEntity, {required this.groupChatEntity});

//   @override
//   List<Object?> get props => [groupChatEntityStream];
// }

// class GroupListError extends GroupListState {
//   GroupListError(super.groupChatEntityStream);

//   @override
//   List<Object?> get props => [];
// }




class GroupListState {
//   GroupListState({
//      this.groups
//   });
//  late Stream<GroupChatEntity>? groups;

}


class EmptyGroupList extends GroupListState{}

class GroupListLoading extends GroupListState{}

class GroupListLoaded extends GroupListState{

  late List<GroupChatEntity> groups;
  GroupListLoaded(this.groups);
}

class ErrorLoadingGroupList extends GroupListState{
  final String error;
  ErrorLoadingGroupList(this.error);
}

class GroupDeleted extends GroupListState{}