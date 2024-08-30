import 'package:equatable/equatable.dart';

class GroupListEvent extends Equatable {
  GroupListEvent();

 
  @override
  List<Object?> get props => [];
}



class OnFetchGroups extends GroupListEvent {
  
  OnFetchGroups();

 
 
}


class OnFetchLastMessage extends GroupListEvent {

     final String? groupId;

     OnFetchLastMessage({required this.groupId});


    @override
  List<Object?> get props => [groupId];
}



class OnGroupDelete extends GroupListEvent {
   final List<String> groups;
  OnGroupDelete({required this.groups});

   @override
  List<Object?> get props => [groups];
}


class OnGroupSearch extends GroupListEvent{}

