import 'package:equatable/equatable.dart';

class GroupListEvent extends Equatable {
  GroupListEvent({
    required this.groupId
  });

  final String groupId;
  @override
  List<Object?> get props => [groupId];
}

class OnGroupsLoainding extends GroupListEvent {
  
  OnGroupsLoainding({required super.groupId});


   @override
  List<Object?> get props => [groupId];
}

class OnGroupsLoaded extends GroupListEvent {
  OnGroupsLoaded({required super.groupId});

   @override
  List<Object?> get props => [groupId];
 
}

class OnGroupLoadError extends GroupListEvent {
  OnGroupLoadError({required super.groupId});

   @override
  List<Object?> get props => [groupId];
}
