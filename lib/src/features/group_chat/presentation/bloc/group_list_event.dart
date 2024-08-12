import 'package:equatable/equatable.dart';

class GroupListEvent extends Equatable {
  GroupListEvent();

 
  @override
  List<Object?> get props => [];
}



class OnFetchGroup extends GroupListEvent {
   final String groupId;
  OnFetchGroup({required this.groupId});

   @override
  List<Object?> get props => [groupId];
 
}


class OnFetchGroups extends GroupListEvent {}



class OnGroupDelete extends GroupListEvent {
   final List<String> groups;
  OnGroupDelete({required this.groups});

   @override
  List<Object?> get props => [groups];
}


